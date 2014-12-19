/**
 * @class L5.LoadMask
 * A simple utility class for generically masking elements while loading data.  If the {@link #dataset}
 * config option is specified, the masking will be automatically synchronized with the dataset's loading
 * process and the mask element will be cached for reuse.  For all other elements, this mask will replace the
 * element's Updater load indicator and will be destroyed after the initial load.
 * <p>Example usage:</p>
 *<pre><code>
// Basic mask:
var myMask = new L5.LoadMask(L5.getBody(), {msg:"Please wait..."});
myMask.show();
</code></pre>
 * @constructor
 * Create a new LoadMask
 * @param {Mixed} el The element or DOM node, or its id
 * @param {Object} config The config object
 */
L5.LoadMask = function(el, config){
    this.el = L5.get(el);
    L5.apply(this, config);
    if(this.dataset){
        this.dataset.on('beforeload', this.onBeforeLoad, this);
        this.dataset.on('load', this.onLoad, this);
        this.dataset.on('loadexception', this.onLoad, this);
        this.removeMask = L5.value(this.removeMask, false);
    }else{
        var um = this.el.getUpdater();
        um.showLoadIndicator = false; // disable the default indicator
        um.on('beforeupdate', this.onBeforeLoad, this);
        um.on('update', this.onLoad, this);
        um.on('failure', this.onLoad, this);
        this.removeMask = L5.value(this.removeMask, true);
    }
};

L5.LoadMask.prototype = {
    /**
     * @cfg {L5.model.Dataset} dataset
     * Optional Dataset to which the mask is bound. The mask is displayed when a load request is issued, and
     * hidden on either load sucess, or load fail.
     */
    /**
     * @cfg {Boolean} removeMask
     * True to create a single-use mask that is automatically destroyed after loading (useful for page loads),
     * False to persist the mask element reference for multiple uses (e.g., for paged data widgets).  Defaults to false.
     */
    /**
     * @cfg {String} msg
     * The text to display in a centered loading message box (defaults to 'Loading...')
     */
    msg : 'Loading...',
    /**
     * @cfg {String} msgCls
     * The CSS class to apply to the loading message element (defaults to "l-mask-loading")
     */
    msgCls : 'l-mask-loading',

    /**
     * Read-only. True if the mask is currently disabled so that it will not be displayed (defaults to false)
     * @type Boolean
     */
    disabled: false,

    /**
     * Disables the mask to prevent it from being displayed
     */
    disable : function(){
       this.disabled = true;
    },

    /**
     * Enables the mask so that it can be displayed
     */
    enable : function(){
        this.disabled = false;
    },

    // private
    onLoad : function(){
        this.el.unmask(this.removeMask);
    },

    // private
    onBeforeLoad : function(){
        if(!this.disabled){
            this.el.mask(this.msg, this.msgCls);
        }
    },

    /**
     * Show this LoadMask over the configured Element.
     */
    show: function(){
        this.onBeforeLoad();
    },

    /**
     * Hide this LoadMask.
     */
    hide: function(){
        this.onLoad();    
    },

    // private
    destroy : function(){
        if(this.dataset){
            this.dataset.un('beforeload', this.onBeforeLoad, this);
            this.dataset.un('load', this.onLoad, this);
            this.dataset.un('loadexception', this.onLoad, this);
        }else{
            var um = this.el.getUpdater();
            um.un('beforeupdate', this.onBeforeLoad, this);
            um.un('update', this.onLoad, this);
            um.un('failure', this.onLoad, this);
        }
    }
};