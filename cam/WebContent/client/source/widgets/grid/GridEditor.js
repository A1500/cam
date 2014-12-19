// private
// This is a support class used internally by the Grid components
L5.grid.GridEditor = function(field, config){
    L5.grid.GridEditor.superclass.constructor.call(this, field, config);
    field.monitorTab = false;
};

L5.extend(L5.grid.GridEditor, L5.Editor, {
    alignment: "tl-tl",
    autoSize: "width",
    hideEl : false,
    cls: "l-small-editor l-grid-editor",
    shim:false,
    shadow:false
});