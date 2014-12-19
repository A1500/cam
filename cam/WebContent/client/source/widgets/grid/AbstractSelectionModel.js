/**
 * grid抽象选择模型接口.  
 * @class L5.grid.AbstractSelectionModel
 * @extends L5.util.Observable
 * @constructor
 */
L5.grid.AbstractSelectionModel = function(){
    this.locked = false;
    L5.grid.AbstractSelectionModel.superclass.constructor.call(this);
};

L5.extend(L5.grid.AbstractSelectionModel, L5.util.Observable,  {
    /** @ignore Called by the grid automatically. Do not call directly. */
    init : function(grid){
        this.grid = grid;
        this.initEvents();
    },

    /**
     * @private
     * Locks the selections.
     */
    lock : function(){
        this.locked = true;
    },

    /**
     * @private
     * Unlocks the selections.
     */
    unlock : function(){
        this.locked = false;
    },

    /**
     * @private
     * Returns true if the selections are locked.
     * @return {Boolean}
     */
    isLocked : function(){
        return this.locked;
    }
});