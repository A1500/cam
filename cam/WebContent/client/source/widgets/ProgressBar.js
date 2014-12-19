/**
 * @class L5.ProgressBar
 * @extends L5.BoxComponent
 * <p>An updateable progress bar component.  The progress bar supports two different modes: manual and automatic.</p>
 * <p>In manual mode, you are responsible for showing, updating (via {@link #updateProgress}) and clearing the
 * progress bar as needed from your own code.  This method is most appropriate when you want to show progress
 * throughout an operation that has predictable points of interest at which you can update the control.</p>
 * <p>In automatic mode, you simply call {@link #wait} and let the progress bar run indefinitely, only clearing it
 * once the operation is complete.  You can optionally have the progress bar wait for a specific amount of time
 * and then clear itself.  Automatic mode is most appropriate for timed operations or asynchronous operations in
 * which you have no need for indicating intermediate progress.</p>
 * @cfg {Float} value A floating point value between 0 and 1 (e.g., .5, defaults to 0)
 * @cfg {String} text The progress bar text (defaults to '')
 * @cfg {Mixed} textEl The element to render the progress text to (defaults to the progress
 * bar's internal text element)
 * @cfg {String} id The progress bar element's id (defaults to an auto-generated id)
 */
L5.ProgressBar = L5.extend(L5.BoxComponent, {
   /**
    * @cfg {String} baseCls
    * The base CSS class to apply to the progress bar's wrapper element (defaults to 'l-progress')
    */
    baseCls : 'l-progress',
    
    /**
    * @cfg {Boolean} animate
    * True to animate the progress bar during transitions (defaults to false)
    */
    animate : false,

    // private
    waitTimer : null,

    // private
    initComponent : function(){
        L5.ProgressBar.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event update
             * Fires after each update interval
             * @param {L5.ProgressBar} this
             * @param {Number} The current progress value
             * @param {String} The current progress text
             */
            "update"
        );
    },

    // private
    onRender : function(ct, position){
        L5.ProgressBar.superclass.onRender.call(this, ct, position);

        var tpl = new L5.Template(
            '<div class="{cls}-wrap">',
                '<div class="{cls}-inner">',
                    '<div class="{cls}-bar">',
                        '<div class="{cls}-text">',
                            '<div>&#160;</div>',
                        '</div>',
                    '</div>',
                    '<div class="{cls}-text {cls}-text-back">',
                        '<div>&#160;</div>',
                    '</div>',
                '</div>',
            '</div>'
        );

        if(position){
            this.el = tpl.insertBefore(position, {cls: this.baseCls}, true);
        }else{
            this.el = tpl.append(ct, {cls: this.baseCls}, true);
        }
        if(this.id){
            this.el.dom.id = this.id;
        }
        var inner = this.el.dom.firstChild;
        this.progressBar = L5.get(inner.firstChild);

        if(this.textEl){
            //use an external text el
            this.textEl = L5.get(this.textEl);
            delete this.textTopEl;
        }else{
            //setup our internal layered text els
            this.textTopEl = L5.get(this.progressBar.dom.firstChild);
            var textBackEl = L5.get(inner.childNodes[1]);
            this.textTopEl.setStyle("z-index", 99).addClass('l-hidden');
            this.textEl = new L5.CompositeElement([this.textTopEl.dom.firstChild, textBackEl.dom.firstChild]);
            this.textEl.setWidth(inner.offsetWidth);
        }
        this.progressBar.setHeight(inner.offsetHeight);
    },
    
    // private
	afterRender : function(){
		L5.ProgressBar.superclass.afterRender.call(this);
		if(this.value){
			this.updateProgress(this.value, this.text);
		}else{
			this.updateText(this.text);
		}
	},

    /**
     * Updates the progress bar value, and optionally its text.  If the text argument is not specified,
     * any existing text value will be unchanged.  To blank out existing text, pass ''.  Note that even
     * if the progress bar value exceeds 1, it will never automatically reset -- you are responsible for
     * determining when the progress is complete and calling {@link #reset} to clear and/or hide the control.
     * @param {Float} value (optional) A floating point value between 0 and 1 (e.g., .5, defaults to 0)
     * @param {String} text (optional) The string to display in the progress text element (defaults to '')
     * @param {Boolean} animate (optional) Whether to animate the transition of the progress bar. If this value is
     * not specified, the default for the class is used (default to false)
     * @return {L5.ProgressBar} this
     */
    updateProgress : function(value, text, animate){
        this.value = value || 0;
        if(text){
            this.updateText(text);
        }
        if(this.rendered){
	        var w = Math.floor(value*this.el.dom.firstChild.offsetWidth);
	        this.progressBar.setWidth(w, animate === true || (animate !== false && this.animate));
	        if(this.textTopEl){
	            //textTopEl should be the same width as the bar so overflow will clip as the bar moves
	            this.textTopEl.removeClass('l-hidden').setWidth(w);
	        }
        }
        this.fireEvent('update', this, value, text);
        return this;
    },

    /**
     * Initiates an auto-updating progress bar.  A duration can be specified, in which case the progress
     * bar will automatically reset after a fixed amount of time and optionally call a callback function
     * if specified.  If no duration is passed in, then the progress bar will run indefinitely and must
     * be manually cleared by calling {@link #reset}.  The wait method accepts a config object with
     * the following properties:
     * <pre>
Property   Type          Description
---------- ------------  ----------------------------------------------------------------------
duration   Number        进度条应该持续的毫秒数 (默认是undefined, 这种情况下会无限循环)
interval   Number        进度条增长间隔时间(默认是 1000 ms)
animate    Boolean       是否有动画效果                                                 
increment  Number        整个进度条分隔的段数，假如是5，那么进度条增长五次就会到末尾，然后重新开始增长(默认是10). 
text       String        进度条上显示的文字(默认 '').
fn         Function      当进度条结束的时候调用的回调方法，没有参数，如果没有指定持续的毫秒数将会被忽略
scope      Object        回调的作用域
</pre>
         *
         * Example usage:
         * <pre><code>
var p = new L5.ProgressBar({
   renderTo: 'my-el'
});

//Wait for 5 seconds, then update the status el (progress bar will auto-reset)
p.wait({
   interval: 100, //bar will move fast!
   duration: 5000,
   increment: 15,
   text: 'Updating...',
   scope: this,
   fn: function(){
      L5.fly('status').update('Done!');
   }
});

//Or update indefinitely until some async action completes, then reset manually
p.wait();
myAction.on('complete', function(){
    p.reset();
    L5.fly('status').update('Done!');
});
</code></pre>
     * @param {Object} config (optional) Configuration options
     * @return {L5.ProgressBar} this
     */
    wait : function(o){
        if(!this.waitTimer){
            var scope = this;
            o = o || {};
            this.updateText(o.text);
            this.waitTimer = L5.TaskMgr.start({
                run: function(i){
                    var inc = o.increment || 10;
                    this.updateProgress(((((i+inc)%inc)+1)*(100/inc))*.01, null, o.animate);
                },
                interval: o.interval || 1000,
                duration: o.duration,
                onStop: function(){
                    if(o.fn){
                        o.fn.apply(o.scope || this);
                    }
                    this.reset();
                },
                scope: scope
            });
        }
        return this;
    },

    /**
     * Returns true if the progress bar is currently in a {@link #wait} operation
     * @return {Boolean} True if waiting, else false
     */
    isWaiting : function(){
        return this.waitTimer != null;
    },

    /**
     * Updates the progress bar text.  If specified, textEl will be updated, otherwise the progress
     * bar itself will display the updated text.
     * @param {String} text (optional) The string to display in the progress text element (defaults to '')
     * @return {L5.ProgressBar} this
     */
    updateText : function(text){
        this.text = text || '&#160;';
        if(this.rendered){
            this.textEl.update(this.text);
        }
        return this;
    },
    
    /**
     * Synchronizes the inner bar width to the proper proportion of the total componet width based
     * on the current progress {@link #value}.  This will be called automatically when the ProgressBar
     * is resized by a layout, but if it is rendered auto width, this method can be called from
     * another resize handler to sync the ProgressBar if necessary.
     */
    syncProgressBar : function(){
        if(this.value){
            this.updateProgress(this.value, this.text);
        }
        return this;
    },

    /**
     * Sets the size of the progress bar.
     * @param {Number} width The new width in pixels
     * @param {Number} height The new height in pixels
     * @return {L5.ProgressBar} this
     */
    setSize : function(w, h){
        L5.ProgressBar.superclass.setSize.call(this, w, h);
        if(this.textTopEl){
            var inner = this.el.dom.firstChild;
            this.textEl.setSize(inner.offsetWidth, inner.offsetHeight);
        }
        this.syncProgressBar();
        return this;
    },

    /**
     * Resets the progress bar value to 0 and text to empty string.  If hide = true, the progress
     * bar will also be hidden (using the {@link #hideMode} property internally).
     * @param {Boolean} hide (optional) True to hide the progress bar (defaults to false)
     * @return {L5.ProgressBar} this
     */
    reset : function(hide){
        this.updateProgress(0);
        if(this.textTopEl){
            this.textTopEl.addClass('l-hidden');
        }
        if(this.waitTimer){
            this.waitTimer.onStop = null; //prevent recursion
            L5.TaskMgr.stop(this.waitTimer);
            this.waitTimer = null;
        }
        if(hide === true){
            this.hide();
        }
        return this;
    }
});
L5.reg('progress', L5.ProgressBar);