/********** CONSTRUCTOR ******
 * Parameters: as per L5.DatePicker
 ****/
L5.DatetimePicker = function(config){
	/** Call superclass constructor **/
	L5.DatetimePicker.superclass.constructor.call(this, config);
};

L5.extend(L5.DatetimePicker, L5.DatePicker, {

	/**
	* Method Name: onRender
	* Description: as per L5.DatePicker's onRender, except renders year in its own cell with arrow-changers in additional columns
	* Parameters: as per L5.DatePicker's onRender
	* Returns: n/a
	* Throws: n/a
	*/
    selectToday : function(){
        this.setValue(new Date().clearTime());
		var val1 = this.value;
		val1.setHours(this.theHours);
		val1.setMinutes(this.theMinutes);
		val1.setSeconds(new Date().getSeconds());
        this.fireEvent("select", this, val1);
    },
    /**
     * 点击确定按钮后触发的方法
     */
    selectConfirm : function(){
    	var val1 = this.value;
		val1.setHours(this.theHours);
		val1.setMinutes(this.theMinutes);
		val1.setSeconds(new Date().getSeconds());
    	this.fireEvent("select", this, val1);
    },
    handleDateClick : function(e, t){
        e.stopEvent();
        if(t.dateValue && !L5.fly(t.parentNode).hasClass("l-date-disabled")){
            this.setValue(new Date(t.dateValue));
			var val1 = this.value;
			val1.setHours(this.theHours);
			val1.setMinutes(this.theMinutes);
			val1.setSeconds(new Date().getSeconds());
			
			if(this.lastSelect){
				L5.fly(this.lastSelect).removeClass("l-date-selected2");
				this.lastSelect = t.parentNode;
				L5.fly(this.lastSelect).addClass("l-date-selected2");
			} else {
				this.lastSelect = t.parentNode;
				L5.fly(this.lastSelect).addClass("l-date-selected2");
			}
//            this.fireEvent("select", this, val1);
        }
    },
 	onRender : function(container, position){
        var m = [
             '<table cellspacing="0">',
                '<tr><td colspan="3"><table cellspacing="0" width="100%"><tr><td class="l-date-left"><a href="#" title="', this.prevText ,'">&#160;</a></td><td class="l-date-middle" align="center"></td><td class="l-date-right"><a href="#" title="', this.nextText ,'">&#160;</a></td></tr></table></td></tr>',
                '<tr><td colspan="3"><table class="l-datetime-inner" width="100%" cellspacing="0"><thead><tr>'];
        var dn = this.dayNames;
        for(var i = 0; i < 7; i++){
            var d = this.startDay+i;
            if(d > 6){
                d = d-7;
            }
            m.push("<th><span>", dn[d].substr(0,1), "</span></th>");
        }
        m[m.length] = "</tr></thead><tbody><tr>";
        for(i = 0; i < 42; i++) {
            if(i % 7 === 0 && i !== 0){
                m[m.length] = "</tr><tr>";
            }
            m[m.length] = '<td><a href="#" hidefocus="on" class="l-date-date" tabIndex="1"><em><span></span></em></a></td>';
        }
		m[m.length] = '</tr></tbody></table></td></tr><tr><td class="minutecss"><table cellspacing="0" width="100%"><tr>';
        m[m.length] = '<td class="l-hour-left"><a href="#" title="down"> </a></td><td class="l-hour-middle"><div class="l-datetimediv-middle"></div></td><td class="l-hour-right"><a href="#" title="up"> </a></td>';
		m[m.length] = '<td class="l-minute-left"><a href="#" title="down"> </a></td><td class="l-minute-middle"><div class="l-datetimediv-middle"></div></td><td class="l-minute-right"><a href="#" title="up"> </a></td>';
		m[m.length] = '</tr></table></td><td  colspan="1" class="l-date-bottom" align="center"><td  colspan="1" class="l-date-bottom" align="center"></td></tr></table><div class="l-date-mp"></div>';

        var el = document.createElement("div");
        el.className = "l-date-picker";
        el.innerHTML = m.join("");
        container.dom.insertBefore(el, position);

        this.el = L5.get(el);
        this.eventEl = L5.get(el.firstChild);

        new L5.util.ClickRepeater(this.el.child("td.l-date-left a"), {
            handler: this.showPrevMonth,
            scope: this,
            preventDefault:true,
            stopDefault:true
        });

        new L5.util.ClickRepeater(this.el.child("td.l-date-right a"), {
            handler: this.showNextMonth,
            scope: this,
            preventDefault:true,
            stopDefault:true
        });
		new L5.util.ClickRepeater(this.el.child("td.l-hour-left a"), {
			handler: function(){
				if(this.theHours>0){
					this.theHours--;
					this.theHours = this.theHours %24;
					var txt = '';
					if(this.theHours<10){
						txt='0'+this.theHours;
					}
					else{
						txt= this.theHours;
					}
					this.hourLabel.update(txt+'时');
					
				}
			}.createDelegate(this), 
			scope: this
		});
		new L5.util.ClickRepeater(this.el.child("td.l-hour-right a"), {
			handler : function() {
				this.theHours++;
				this.theHours = this.theHours % 24;
				var txt = '';
				if (this.theHours < 10) {
					txt = '0' + this.theHours;
				} else {
					txt = this.theHours;
				}
				this.hourLabel.update(txt+'时');
			}.createDelegate(this),
			scope : this
		});
		new L5.util.ClickRepeater(this.el.child("td.l-minute-left a"), {
			handler : function() {
				if (this.theMinutes > 0) {
					this.theMinutes--;
					this.theMinutes = this.theMinutes % 60;
					var txt = '';
					if (this.theMinutes < 10) {
						txt = '0' + this.theMinutes;
					} else {
						txt = this.theMinutes;
					}
					this.minuteLabel.update(txt+'分');

				}
			}.createDelegate(this),
			scope : this
		});
		new L5.util.ClickRepeater(this.el.child("td.l-minute-right a"), {
			handler : function() {
				this.theMinutes++;
				this.theMinutes = this.theMinutes % 60;
				var txt = '';
				if (this.theMinutes < 10) {
					txt = '0' + this.theMinutes;
				} else {
					txt = this.theMinutes;
				}
				this.minuteLabel.update(txt+'分');
			}.createDelegate(this),
			scope : this
		});

        this.eventEl.on("mousewheel", this.handleMouseWheel,  this);

        this.monthPicker = this.el.down('div.l-date-mp');
        this.monthPicker.enableDisplayMode('block');
        
        var kn = new L5.KeyNav(this.eventEl, {
            "left" : function(e){
                e.ctrlKey ?
                    this.showPrevMonth() :
                    this.update(this.activeDate.add("d", -1));
            },

            "right" : function(e){
                e.ctrlKey ?
                    this.showNextMonth() :
                    this.update(this.activeDate.add("d", 1));
            },

            "up" : function(e){
                e.ctrlKey ?
                    this.showNextYear() :
                    this.update(this.activeDate.add("d", -7));
            },

            "down" : function(e){
                e.ctrlKey ?
                    this.showPrevYear() :
                    this.update(this.activeDate.add("d", 7));
            },

            "pageUp" : function(e){
                this.showNextMonth();
            },

            "pageDown" : function(e){
                this.showPrevMonth();
            },

            "enter" : function(e){
                e.stopPropagation();
                return true;
            },

            scope : this
        });

        this.eventEl.on("click", this.handleDateClick,  this, {delegate: "a.l-date-date"});
       
        this.eventEl.addKeyListener(L5.EventObject.SPACE, this.selectToday,  this);
        
        this.eventEl.addKeyListener(L5.EventObject.ENTER, this.selectConfirm,  this);

        this.el.unselectable();
        
        this.cells = this.el.select("table.l-datetime-inner tbody td");
        this.textNodes = this.el.query("table.l-datetime-inner tbody span");

        this.mbtn = new L5.Button({
            text: "&#160;",
            tooltip: this.monthYearText,
            renderTo: this.el.child("td.l-date-middle", true)
        });

        this.mbtn.on('click', this.showMonthPicker, this);
        this.mbtn.el.child(this.mbtn.menuClassTarget).addClass("l-btn-with-menu");

		var dt1 = new Date();
		var txt = '';
		this.hourLabel = this.el.child("td.l-hour-middle").first();
//		this.hourLabel.on("click",this.showHoursSelection,this);
		this.hourLabel.on("mouseover",this.showHoursSelection,this);
		this.theHours = dt1.getHours();
		if(this.theHours<10){
			txt='0'+this.theHours;
		}
		else{
			txt= this.theHours;
		}	
		this.hourLabel.update(txt+'时');

		this.minuteLabel = this.el.child("td.l-minute-middle").first();
//		this.minuteLabel.on("click",this.showMinutesSelection,this);
		this.minuteLabel.on("mouseover",this.showMinutesSelection,this);
		this.theMinutes = dt1.getMinutes();
		if(this.theMinutes<10){
			txt='0'+this.theMinutes;
		}
		else{
			txt= this.theMinutes;
		}	
		this.minuteLabel.update(txt+'分');

        var today = (new Date()).dateFormat(this.format);
        var todayBtn = new L5.Button({
            renderTo: L5.getDom(this.el.query("td.l-date-bottom")[1]),
            text: String.format(this.todayText, today),
            tooltip: String.format(this.todayTip, today),
            handler: this.selectToday,
            scope: this
        });
        
        var confirmBtn = new L5.Button({
            renderTo: L5.getDom(this.el.query("td.l-date-bottom")[0]),
            text: "确定",
            tooltip: "回车选择",
            handler: this.selectConfirm,
            scope: this
        });
        
        if(L5.isIE){
            this.el.repaint();
        }
        this.update(this.value);
	},
	hideHourOrminuteMenu : function(){
		if(this.hasHoursMenu && this.hourMenu)
			this.hourMenu.fireEvent("hide",this.hourMenu);
    	if(this.hasMinutesMenu && this.minutesMenu)
			this.minutesMenu.fireEvent("hide",this.minutesMenu);
	},
	showHoursSelection :function(event,obj){
		if(this.hasMinutesMenu && this.minutesMenu)
			this.minutesMenu.fireEvent("hide",this.minutesMenu);
		if(this.hasHoursMenu)
			return;
		var m = ['<table class="l-datetime-inner" width="100%" cellspacing="0"><tbody><tr>'];
		for(i = 0; i < 24; i++) {
			if(i % 6 === 0 && i !== 0){
				m[m.length] = '</tr><tr>';
		    }
		    m[m.length] = '<td><a href="#" hidefocus="on" class="l-date-date" tabIndex="1"><em><span>'+i+'</span></em></a></td>';
		}
		m[m.length] = '</tr></tbody></table>';
		
		var menu = new L5.menu.Menu({cls:'l-date-menu'});
		this.hourMenu = menu;
		this.hasHoursMenu = true;
		var menuItem = new L5.menu.Item({ itemCls:'l-menu-date-item',text: m.join("")});
		menu.add(menuItem);
		menu.render();
		var xy = event.xy;
		xy = menu.el.adjustForConstraints(xy);
		menu.el.setXY(xy);
		menu.el.show();
		menu.hidden = false;
		menu.focus();
		menu.on("show",this.showHoursMenuInit,this);
		menu.fireEvent("show",menu);
		menu.on("hide",this.destroyHoursMenu,this);
		L5.get(menuItem.el).on("click", this.showHours,this,{delegate: "a.l-date-date"});
	},
	showHoursMenuInit : function(menu){
		var cells = menu.el.query("table.l-datetime-inner tbody td");
		var hours = this.theHours;
		L5.get(cells).each(function(c){
            if((c.dom.firstChild.innerText || c.dom.firstChild.textContent) == hours){
                c.addClass("l-date-selected");
                c.addClass("l-date-today");
                setTimeout(function(){
                     try{c.dom.firstChild.focus();}catch(e){}
                }, 50);
                return false;
            }
         });
	},
	destroyHoursMenu :function(menu){
		menu.destroy();
		this.hourMenu = undefined ;
		this.hasHoursMenu=false;
	},
	showHours : function(e,t){
		this.hasHoursMenu=false;
		this.theHours = t.innerText||t.textContent;
		var txt="";
		if(this.theHours<10){
			txt='0'+this.theHours;
		}
		else{
			txt= this.theHours;
		}	
		this.hourLabel.update(txt+'时');
	},
	showMinutesSelection : function(event,obj){
		if(this.hasHoursMenu && this.hourMenu)
			this.hourMenu.fireEvent("hide",this.hourMenu);
		if(this.hasMinutesMenu)
			return;
		var m = ['<table class="l-datetime-inner" width="100%" cellspacing="0"><tbody><tr>'];
		for(i = 0; i < 60; i++) {
			if(i % 10 === 0 && i !== 0){
				m[m.length] = '</tr><tr>';
		    }
		    m[m.length] = '<td><a href="#" hidefocus="on" class="l-date-date" tabIndex="1"><em><span>'+i+'</span></em></a></td>';
		}
		m[m.length] = '</tr></tbody></table>';
		
		var menu = new L5.menu.Menu({cls:'l-date-menu'});
		this.hasMinutesMenu = true;
		this.minutesMenu = menu;
		var menuItem = new L5.menu.Item({ itemCls:'l-menu-date-item',text: m.join("")});
		menu.add(menuItem);
		menu.render();
		var xy = event.xy;
		xy = menu.el.adjustForConstraints(xy);
		menu.el.setXY(xy);
		menu.el.show();
		menu.hidden = false;
		menu.focus();
		menu.on("show",this.showMinutesMenuInit,this);
		menu.fireEvent("show",menu);
		menu.on("hide",this.destroyMinutesMenu,this);
		L5.get(menuItem.el).on("click", this.showMinutes,this,{delegate: "a.l-date-date"});
	},
	showMinutesMenuInit : function(menu){
		var cells = menu.el.query("table.l-datetime-inner tbody td");
		var minutes = this.theMinutes;
		L5.get(cells).each(function(c){
            if((c.dom.firstChild.innerText || c.dom.firstChild.textContent) == minutes){
                c.addClass("l-date-selected");
                c.addClass("l-date-today");
                setTimeout(function(){
                     try{c.dom.firstChild.focus();}catch(e){}
                }, 50);
                return false;
            }
         });
	},
	destroyMinutesMenu :function(menu){
		menu.destroy();
		this.minutesMenu = undefined;
		this.hasMinutesMenu=false;
	},
	showMinutes : function(e,t){
		this.hasMinutesMenu=false;
		this.theMinutes = t.innerText||t.textContent;
		var txt="";
		if(this.theMinutes<10){
			txt='0'+this.theMinutes;
		}
		else{
			txt= this.theMinutes;
		}	
		this.minuteLabel.update(txt+'分');
	},
	/**
	* Method Name: update
	* Description: as per L5.DatePicker's update, except updates year label in its own cell
	* Parameters: as per L5.DatePicker's update
	* Returns: n/a
	* Throws: n/a
	*/
	update : function(date){
		this.hideHourOrminuteMenu();
        var vd = this.activeDate;
        this.activeDate = date;
        if(vd && this.el){
            var t = date.getTime();
            if(vd.getMonth() == date.getMonth() && vd.getFullYear() == date.getFullYear()){
                this.cells.removeClass("l-date-selected");
                this.cells.each(function(c){
                   if(c.dom.firstChild.dateValue == t){
                       c.addClass("l-date-selected");
                       setTimeout(function(){
                            try{c.dom.firstChild.focus();}catch(e){}
                       }, 50);
                       return false;
                   }
                });
                return;
            }
        }
        var days = date.getDaysInMonth();
        var firstOfMonth = date.getFirstDateOfMonth();
        var startingPos = firstOfMonth.getDay()-this.startDay;

        if(startingPos <= this.startDay){
            startingPos += 7;
        }

        var pm = date.add("mo", -1);
        var prevStart = pm.getDaysInMonth()-startingPos;

        var cells = this.cells.elements;
        var textEls = this.textNodes;
        days += startingPos;

        // convert everything to numbers so it's fast
        var day = 86400000;
        var d = (new Date(pm.getFullYear(), pm.getMonth(), prevStart)).clearTime();
        var today = new Date().clearTime().getTime();
        var sel = date.clearTime().getTime();
        var min = this.minDate ? this.minDate.clearTime() : Number.NEGATIVE_INFINITY;
        var max = this.maxDate ? this.maxDate.clearTime() : Number.POSITIVE_INFINITY;
        var ddMatch = this.disabledDatesRE;
        var ddText = this.disabledDatesText;
        var ddays = this.disabledDays ? this.disabledDays.join("") : false;
        var ddaysText = this.disabledDaysText;
        var format = this.format;

        var setCellClass = function(cal, cell){
            cell.title = "";
            var t = d.getTime();
            cell.firstChild.dateValue = t;
            if(t == today){
                cell.className += " l-date-today";
                cell.title = cal.todayText;
            }
            if(t == sel){
                cell.className += " l-date-selected";
                setTimeout(function(){
                    try{cell.firstChild.focus();}catch(e){}
                }, 50);
            }
            // disabling
            if(t < min) {
                cell.className = " l-date-disabled";
                cell.title = cal.minText;
                return;
            }
            if(t > max) {
                cell.className = " l-date-disabled";
                cell.title = cal.maxText;
                return;
            }
            if(ddays){
                if(ddays.indexOf(d.getDay()) != -1){
                    cell.title = ddaysText;
                    cell.className = " l-date-disabled";
                }
            }
            if(ddMatch && format){
                var fvalue = d.dateFormat(format);
                if(ddMatch.test(fvalue)){
                    cell.title = ddText.replace("%0", fvalue);
                    cell.className = " l-date-disabled";
                }
            }
        };

        var i = 0;
        for(; i < startingPos; i++) {
            textEls[i].innerHTML = (++prevStart);
            d.setDate(d.getDate()+1);
            cells[i].className = "l-date-prevday";
            setCellClass(this, cells[i]);
        }
        for(; i < days; i++){
            intDay = i - startingPos + 1;
            textEls[i].innerHTML = (intDay);
            d.setDate(d.getDate()+1);
            cells[i].className = "l-date-active";
            setCellClass(this, cells[i]);
        }
        var extraDays = 0;
        for(; i < 42; i++) {
             textEls[i].innerHTML = (++extraDays);
             d.setDate(d.getDate()+1);
             cells[i].className = "l-date-nextday";
             setCellClass(this, cells[i]);
        }

        this.mbtn.setText(this.monthNames[date.getMonth()] + " " + date.getFullYear());

		if(this.theHours<10){
			txt='0'+this.theHours;
		}
		else{
			txt= this.theHours;
		}
		this.hourLabel.update(txt+'时');

		if(this.theMinutes<10){
			txt='0'+this.theMinutes;
		}
		else{
			txt= this.theMinutes;
		}	
		this.minuteLabel.update(txt+'分');

        if(!this.internalRender){
            var main = this.el.dom.firstChild;
            var w = main.offsetWidth;
            this.el.setWidth(w + this.el.getBorderWidth("lr"));
            L5.fly(main).setWidth(w);
            this.internalRender = true;
            // opera does not respect the auto grow header center column
            // then, after it gets a width opera refuses to recalculate
            // without a second pass
            if(L5.isOpera && !this.secondPass){
                main.rows[0].cells[1].style.width = (w - (main.rows[0].cells[0].offsetWidth+main.rows[0].cells[2].offsetWidth)) + "px";
                this.secondPass = true;
                this.update.defer(10, this, [date]);
            }
        }
	},
	
	/***** Public Instance Variables *****/
	
	/**
	* Variable Name: nextYearText, prevYearText
	* Description: Hover text for the previous year and next year arrow changers
	* Default: as shown
	* Type: string
	*/
	nextYearText: 'Next Year (Control+Up)',
	prevYearText: 'Previous Year (Control+Down)'
});