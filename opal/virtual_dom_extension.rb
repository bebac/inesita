module VirtualDOM
  class NodeFactory
    def component(comp, opts = {})
      fail "Component is nil in #{@parent.class} class" if comp.nil?
      @nodes << @parent.cache_component(comp) do
        (comp.is_a?(Class) ? comp.new : comp)
          .with_root_component(@parent.root_component)
          .with_router(@parent.router)
          .with_store(@parent.store)
      end.with_props(opts[:props] || {}).render
    end

    def a(params, &block)
      params = { onclick: -> { @parent.router.handle_link(params[:href]) } }.merge(params) if params[:href] && @parent.router
      @nodes << VirtualNode.new(
        'a',
        process_params(params),
        block ? NodeFactory.new(block, @parent).nodes : []
      ).vnode
    end
  end
end
