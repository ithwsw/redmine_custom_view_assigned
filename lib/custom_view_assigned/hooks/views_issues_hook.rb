class ViewsIssueHook < Redmine::Hook::Listener
  def view_issues_form_details_bottom(context)
    users = RedmineCustomViewAssigned.filtering_users == 'true' ?
        helpers.assignable_users(context[:issue]) :
        context[:issue].assignable_users

    case RedmineCustomViewAssigned.grouping_mode
      when 'groups' then
        context[:controller].send(
            :render_to_string, {
                                 :partial => 'issues/assigned_grouping',
                                 :layout => false,
                                 :locals => {:groups => grouping_by_group(users)}
                             })
      when 'roles' then
        context[:controller].send(
            :render_to_string, {
                                 :partial => 'issues/assigned_grouping',
                                 :layout => false,
                                 :locals => {:groups => grouping_by_role(users,context[:issue])}
                             })
      else
        context[:controller].send(
            :render_to_string, {
                                 :partial => 'issues/assigned_not_grouping',
                                 :layout => false,
                                 :locals => {:users => users}
                             })
    end
  end

  private
  def add_entry_to_group(groups, group_name, entry_id, entry_name)
    unless groups.has_key? group_name
      groups[group_name] = []
    end

    groups[group_name] << {id: entry_id, name: entry_name}
  end

  def grouping_by_group(users)
    groups = {}

    label_no_group = l(:label_custom_view_assigned_no_group)
    add_entry_to_group(groups, label_no_group, User.current.id, "<< #{l(:label_me)} >>")

    users.each do |user|
      if user.instance_of? Group
        add_entry_to_group(groups, h(l(:label_group_plural)), user.id, user.name)
      else
        if user.groups.empty?
          add_entry_to_group(groups, label_no_group, user.id, user.name)
        end

        user.groups.each do |user_group|
          add_entry_to_group(groups, user_group.name, user.id, user.name)
        end
      end
    end

    groups
  end
  # Quick fix for the error message: "builtin not found" while running the method "def <=>(role)" in app/modles/roles.rb
  # Remark following line to remove "Current user" in groups in order to prevent error occured. 
  # add_entry_to_group(groups, l(:label_custom_view_assigned_current_user), User.current.id, "<< #{l(:label_me)} >>")
  def grouping_by_role(users,issue)
    groups = {}
    current_project = Project.find(issue.project_id)
    
    # add_entry_to_group(groups, l(:label_custom_view_assigned_current_user), User.current.id, "<< #{l(:label_me)} >>")

    Role.order(:position).each do |role|
      users.each do |user|
        if user.roles_for_project(current_project).include? role
          add_entry_to_group(groups, role, user.id, user.name)
        end
      end
    end

    groups
  end
end

class InitHelpers
  include Singleton
  include CustomViewAssignedHelper
end

def helpers
  InitHelpers.instance
end
