class <%=class_name.pluralize%>Controller < ApplicationController
  def index
    @nester = find_and_authorize_nester(nesters)
    @<%=plural_table_name%> = load_authorized_collection(@nester)
  end

  def show
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = load_and_authorize_member(@nester)
  end

  def new
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = build_and_authorize_member(@nester)
  end

  def edit
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = load_and_authorize_member(@nester)
  end

  def create
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = build_and_authorize_member(@nester, <%=singular_table_name%>_params)

    if @<%=singular_table_name%>.save
      redirect_to (@nester || @<%=singular_table_name%>), notice: '<%=class_name.titleize%> was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = load_and_authorize_member(@nester, <%=singular_table_name%>_params)

    if @<%=singular_table_name%>.save
      redirect_to (@nester || @<%=singular_table_name%>), notice: '<%=class_name.titleize%> was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @nester = find_and_authorize_nester(nesters)
    @<%=singular_table_name%> = load_and_authorize_member(@nester)

    if @<%=singular_table_name%>.destroy
      redirect_to (@nester || <%=table_name%>_path), notice: 'Deleted <%=singular_table_name.titleize.downcase%>'
    else
      render action: 'show', notice: 'Failed to delete <%=class_name.titleize.downcase%>'
    end
  end

  def self.default_params
    [<%=(belongs_to_associations.map{|bt| "#{bt}_id"} + content_columns).map{|c| ":#{c}"}.join(', ')%>]
  end

  protected

  def nesters
    [<%=belongs_to_associations.map{|c|":#{c}"}.join(', ')%>]
  end

  def <%=singular_table_name%>_params
    params.require(:<%=singular_table_name%>).permit(
      *self.class.default_params,
<% has_many_associations.find_all{|hm| association_class_exists_with_this_name?(hm)}.each do |hm| -%>
      <%=hm%>_attributes: <%=hm.to_s.classify.pluralize%>Controller.default_params + [:id, :_destroy],
<% end -%>
    )
  end
end
