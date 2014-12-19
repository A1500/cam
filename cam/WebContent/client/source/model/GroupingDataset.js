/**
 * Dataset的具体实现，根据某个域实现records的分组。通常会跟L5.grid.GroupingView联合使用，给分组Grid提供数据模型。
 * @class L5.model.GroupingDataset
 * @extends L5.model.Dataset
 * @constructor
 * 创建GroupingDataset对象
 * @param {Object} config 包含Dataset访问数据的对象和读取数据到Records的配置对象
 */
L5.model.GroupingDataset = L5.extend(L5.model.Dataset, {
    /**
     * @cfg {String} groupField 排序域的名称，默认是''
     */
	
    /**
     * @cfg {Boolean} remoteGroup 远程分组，如果是true，在服务器端分组，否则在客户端。如果在服务器端分组，需要将域名称作为'groupBy'参数发送到服务器端
     * @default false
     */
    remoteGroup : false,
    /**
     * @cfg {Boolean} groupOnSort 如果是true，每次执行分组操作时，会根据分组域排序，否则会基于现有的排序规则排序
     * @default false
     */
    groupOnSort:false,

    /**
     * 清除所有的分组并按照默认的排序规则刷新数据
     * @method clearGrouping
     */
    clearGrouping : function(){
        this.groupField = false;
        if(this.remoteGroup){
            if(this.baseParams){
                delete this.baseParams.groupBy;
            }
            this.reload();
        }else{
            this.applySort();
            this.fireEvent('datachanged', this);
        }
    },

    /**
     * 根据指定的域分组数据
     * @method groupBy
     * @param {String} field dataset中的数据排序所依据的域名称
     * @param {Boolean} forceRegroup (可选) 如果是true，则强制刷新分组，即使传入的与名称跟当前的相同，否则忽略(默认是false)
     */
    groupBy : function(field, forceRegroup){
        if(this.groupField == field && !forceRegroup){
            return; 
        }
        this.groupField = field;
        if(this.remoteGroup){
            if(!this.baseParams){
                this.baseParams = {};
            }
            this.baseParams['groupBy'] = field;
        }
        if(this.groupOnSort){
            this.sort(field);
            return;
        }
        if(this.remoteGroup){
            this.reload();
        }else{
            var si = this.sortInfo || {};
            if(si.field != field){
                this.applySort();
            }else{
                this.sortData(field);
            }
            this.fireEvent('datachanged', this);
        }
    },

    /**
     * 应用排序
     * @method applySort
     * @private
     */
    applySort : function(){
        L5.model.GroupingDataset.superclass.applySort.call(this);
        if(!this.groupOnSort && !this.remoteGroup){
            var gs = this.getGroupState();
            if(gs){
            	if(this.sortInfo && gs != this.sortInfo.field){
            		this.sortData(this.groupField);
            	}else if(this.sortInfo == undefined){
            		this.sortData(this.groupField);
            	}
            }
        }
    },

    /**
     * 执行分组
     * @method applyGrouping
     * @private
     * @param {Boolean} alwaysFireChange 是否触发datachanged事件
     */
    applyGrouping : function(alwaysFireChange){
        if(this.groupField !== false){
            this.groupBy(this.groupField, true);
            return true;
        }else{
            if(alwaysFireChange === true){
                this.fireEvent('datachanged', this);
            }
            return false;
        }
    },

    /**
     * 返回排序信息
     * @method getGroupState
     * @private
     */
    getGroupState : function(){
        return this.groupOnSort && this.groupField !== false ?
               (this.sortInfo ? this.sortInfo.field : undefined) : this.groupField;
    }
});