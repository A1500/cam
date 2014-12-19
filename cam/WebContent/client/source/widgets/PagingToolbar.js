//doc
/**
 * @class L5.PagingToolbar
 * @extends L5.Toolbar
 */
// * <p>A specialized toolbar that is bound to a {@link L5.model.Dataset} and provides automatic paging control. This
// * Component {@link L5.model.Dataset#load load}s blocks of data into the Dataset passing parameters who's names are
// * specified by the dataset's {@link L5.model.Dataset#paramNames paramNames} property.</p>
// * @constructor
// * Create a new PagingToolbar
// * @param {Object} config The config object
L5.PagingToolbar = L5.extend(L5.Toolbar, {
    /**
     * @cfg {L5.model.Dataset} dataset 翻页栏使用的数据来源{@link L5.model.Dataset}(必填选项).
     */
    /**
     * @cfg {Boolean} displayInfo
     * true展示如一共多少条之类的信息(默认是true)
     */
     displayInfo : true,
    /**
     * @ignore
     * @cfg {Number} pageSize
     * The number of records to display per page (defaults to 20)
     */
    //pageSize: 20, //caoxm remove it to dataset
    /**
     * @cfg {String} displayMsg
     * 翻页信息(默认是"Displaying {0} - {1} of {2}").第一个{0}是从第几，第二个{1}是到第几，最后一个{2}是一共多少条
     */
    displayMsg : 'Displaying {0} - {1} of {2}',
    /**
     * @cfg {String} emptyMsg
     * 当没有数据需要显示的时候展示的文字(默认是"No data to display")
     */
    emptyMsg : 'No data to display',
    /**
     * Customizable piece of the default paging text (defaults to "Page")
     * @type String @hide
     */
    beforePageText : "Page",
    /**
     * Customizable piece of the default paging text (defaults to "of {0}"). Note that this string is
     * formatted using {0} as a token that is replaced by the number of total pages. This token should be
     * preserved when overriding this string if showing the total page count is desired.
     * @type String @hide
     */
    afterPageText : "of {0}",
    /**
     * Customizable piece of the default paging text (defaults to "First Page")
     * @type String @hide
     */
    firstText : "First Page",
    /**
     * Customizable piece of the default paging text (defaults to "Previous Page")
     * @type String @hide
     */
    prevText : "Previous Page",
    /**
     * Customizable piece of the default paging text (defaults to "Next Page")
     * @type String @hide
     */
    nextText : "Next Page",
    /**
     * Customizable piece of the default paging text (defaults to "Last Page")
     * @type String @hide
     */
    lastText : "Last Page",
    /**
     * Customizable piece of the default paging text (defaults to "Refresh")
     * @type String @hide
     */
    refreshText : "Refresh",

    /**
     * @ignore
     * Object mapping of parameter names for load calls (defaults to {start: 'start', limit: 'limit'})
     */
    paramNames : {start: 'start', limit: 'limit'},

    // private
    initComponent : function(){
        this.addEvents(
            /**
             * @ignore
             * @event change
             * Fires after the active page has been changed.
             * @param {L5.PagingToolbar} this
             * @param {Object} changeEvent An object that has these properties:<ul>
             * <li><code>total</code> : Number <div class="sub-desc">The total number of records in the dataset as
             * returned by the server</div></li>
             * <li><code>activePage</code> : Number <div class="sub-desc">The current page number</div></li>
             * <li><code>pages</code> : Number <div class="sub-desc">The total number of pages (calculated from
             * the total number of records in the dataset as returned by the server and the current {@link #pageSize})</div></li>
             * </ul>
             */
            'change',
            /**
             * @ignore
             * @event beforechange
             * Fires just before the active page is changed.
             * Return false to prevent the active page from being changed.
             * @param {L5.PagingToolbar} this
             * @param {Object} beforeChangeEvent An object that has these properties:<ul>
             * <li><code>start</code> : Number <div class="sub-desc">The starting row number for the next page of records to
             * be retrieved from the server</div></li>
             * <li><code>limit</code> : Number <div class="sub-desc">The number of records to be retrieved from the server</div></li>
             * </ul>
             * (note: the names of the <b>start</b> and <b>limit</b> properties are determined
             * by the dataset's {@link L5.model.Dataset#paramNames paramNames} property.)
             */
            'beforechange'
        );
        L5.PagingToolbar.superclass.initComponent.call(this);
        this.bind(this.dataset);
    },

    // private
    onRender : function(ct, position){
        L5.PagingToolbar.superclass.onRender.call(this, ct, position);
        this.first = this.addButton({
            tooltip: this.firstText,
            iconCls: "l-tbar-page-first",
            disabled: true,
            handler: this.onClick.createDelegate(this, ["first"])
        });
        this.prev = this.addButton({
            tooltip: this.prevText,
            iconCls: "l-tbar-page-prev",
            disabled: true,
            handler: this.onClick.createDelegate(this, ["prev"])
        });
        this.addSeparator();
        this.add(this.beforePageText);
        this.field = L5.get(this.addDom({
           tag: "input",
           type: "text",
           size: "3",
           value: "1",
           cls: "l-tbar-page-number"
        }).el);
        this.field.on("keydown", this.onPagingKeydown, this);
        this.field.on("focus", function(){this.dom.select();});
        this.field.on("blur", this.onPagingBlur, this);
        this.afterTextEl = this.addText(String.format(this.afterPageText, 1));
        this.field.setHeight(18);
        this.addSeparator();
        this.next = this.addButton({
            tooltip: this.nextText,
            iconCls: "l-tbar-page-next",
            disabled: true,
            handler: this.onClick.createDelegate(this, ["next"])
        });
        this.last = this.addButton({
            tooltip: this.lastText,
            iconCls: "l-tbar-page-last",
            disabled: true,
            handler: this.onClick.createDelegate(this, ["last"])
        });
        this.addSeparator();
        this.loading = this.addButton({
            tooltip: this.refreshText,
            iconCls: "l-tbar-loading",
            handler: this.onClick.createDelegate(this, ["refresh"])
        });

        if(this.displayInfo){
            this.displayEl = L5.fly(this.el.dom).createChild({cls:'l-paging-info'});
        }
        if(this.dsLoaded){
            this.onLoad.apply(this, this.dsLoaded);
        }
    },

    // private
    updateInfo : function(){
        if(this.displayEl){
            var count = this.dataset.getCount();
            var cursor=this.dataset.getStartCursor();
            var total=this.dataset.getTotalCount();
            var pageSize = this.dataset.getPageSize();
            if(cursor+pageSize>total){
            	total = cursor+count;
            }else{
            	total = total;
            }
            var msg = count == 0 ? this.emptyMsg : String.format(this.displayMsg,cursor+1, cursor+count,total );
            this.displayEl.update(msg);
        }
    },

    // private
    onLoad : function(dataset, r, o){
        if(!this.rendered){
            this.dsLoaded = [dataset, r, o];
            return;
        }
        var d = this.getPageData();

        this.afterTextEl.el.innerHTML = String.format(this.afterPageText, Math.max(d.pages,1));
        this.field.dom.value = d.activePage;//current page
        this.first.setDisabled(this.dataset.isFirstPage());
        this.prev.setDisabled(this.dataset.isFirstPage());
        this.next.setDisabled(this.dataset.isLastPage());
        this.last.setDisabled(this.dataset.isLastPage());
        this.loading.enable();
        this.updateInfo();
        this.fireEvent('change', this, d);
    },

    // private
    getPageData : function(){
        return {
            total : this.dataset.getTotalCount(),
            activePage : this.dataset.getPageIndex(),
            pages :  this.dataset.getTotalPage()
        };
    },

    // private
    onLoadError : function(){
        if(!this.rendered){
            return;
        }
        this.loading.enable();
    },

    // private
    readPage : function(d){
        var v = this.field.dom.value, pageNum;
        if (!v || isNaN(pageNum = parseInt(v, 10))) {
            this.field.dom.value = d.activePage;
            return false;
        }
        return pageNum;
    },

    //private
    onPagingBlur: function(e){
        this.field.dom.value = this.getPageData().activePage;
    },

    // private
    onPagingKeydown : function(e){
        var k = e.getKey(), d = this.getPageData(), pageNum;
        if (k == e.RETURN) {
            e.stopEvent();
            pageNum = this.readPage(d);
            if(pageNum !== false){
                pageNum = Math.min(Math.max(1, pageNum), d.pages);
                this.changePage(pageNum);
            }
        }else if (k == e.HOME || k == e.END){
            e.stopEvent();
            pageNum = k == e.HOME ? 1 : d.pages;
            this.field.dom.value = pageNum;
        }else if (k == e.UP || k == e.PAGEUP || k == e.DOWN || k == e.PAGEDOWN){
            e.stopEvent();
            if(pageNum = this.readPage(d)){
                var increment = e.shiftKey ? 10 : 1;
                if(k == e.DOWN || k == e.PAGEDOWN){
                    increment *= -1;
                }
                pageNum += increment;
                if(pageNum >= 1 & pageNum <= d.pages){
                    this.field.dom.value = pageNum;
                }
            }
        }
    },

    // private
    beforeLoad : function(){
        if(this.rendered && this.loading){
            this.loading.disable();
        }
    },


    /**
     * Change the active page
     * @ignore
     * @param {Integer} page The page to display
     */
    changePage: function(page){
        this.dataset.turnPage(page);
    },

    // private
    onClick : function(which){
        var ds = this.dataset;
        switch(which){
            case "first":
                ds.turnFirst();
            break;
            case "prev":
                ds.turnPrev();
            break;
            case "next":
                ds.turnNext();
            break;
            case "last":
                ds.turnLast();
            break;
            case "refresh":
                ds.reload();
            break;
        }
    },

    /**
     * @ignore
     * Unbinds the paging toolbar from the specified {@link L5.model.Dataset}
     * @param {L5.model.Dataset} dataset The data dataset to unbind
     */
    unbind : function(dataset){
        dataset = L5.DatasetMgr.lookup(dataset);
        dataset.un("beforeload", this.beforeLoad, this);
        dataset.un("load", this.onLoad, this);
        dataset.un("add", this.onLoad, this);
        dataset.un("remove", this.onLoad, this);
        dataset.un("clear", this.onLoad, this);
        dataset.un("datachanged", this.onLoad, this);
        dataset.un("loadexception", this.onLoadError, this);
        this.dataset = undefined;
    },

    /**
     * @ignore
     * Binds the paging toolbar to the specified {@link L5.model.Dataset}
     * @param {L5.model.Dataset} dataset The data dataset to bind
     */
    bind : function(dataset){
        dataset = L5.DatasetMgr.lookup(dataset);
        dataset.on("beforeload", this.beforeLoad, this);
        dataset.on("load", this.onLoad, this);
        dataset.on("add", this.onLoad, this);
        dataset.on("remove", this.onLoad, this);
        dataset.on("clear", this.onLoad, this);
        dataset.on("datachanged", this.onLoad, this);
        dataset.on("loadexception", this.onLoadError, this);
        this.dataset = dataset;
        this.onLoad(this.dataset);
    },

    // private
    onDestroy : function(){
        if(this.dataset){
            this.unbind(this.dataset);
        }
        L5.PagingToolbar.superclass.onDestroy.call(this);
    }
});
L5.reg('paging', L5.PagingToolbar);