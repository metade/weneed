/**
*
*  Javascript pie menu
*  http://www.webtoolkit.info/
*
**/

var PieContextMenu = {

    // private properties.
    itemWidth : 750,
    itemHeight : 750,
    menuClassName : 'PieContextMenu',
    menus : new Array,
    menuElement : null,
    menuElementId : null,

    // private properties. Browser detect. Do not touch! :)
    IE : ( document.all && document.getElementById && !window.opera ),
    FF : (!document.all && document.getElementById && !window.opera),


    // private method. Initialize
    init : function () {

        if ( PieContextMenu.FF ) {
            document.addEventListener("DOMContentLoaded", PieContextMenu.domReady, false);
        }

        if ( PieContextMenu.IE ) {

            document.write("<scr" + "ipt id=__ieinit_PieContextMenu defer=true " +
                "src=//:><\/script>");

            var script = document.getElementById("__ieinit_PieContextMenu");
            script.onreadystatechange = function() {
                if ( this.readyState != "complete" ) return;
                this.parentNode.removeChild( this );
                PieContextMenu.domReady();
            };

            script = null;
        }

    },


    // private method. Initialize all menus.
    domReady : function () {

        var menus = document.body.getElementsByTagName('ul');

        for(var i = 0; i < menus.length; i++) {
            var className = menus[i].className.replace(/^\s+/g, "").replace(/\s+$/g, "");
            var classArray = className.split(/[ ]+/g);

            for (var k = 0; k < classArray.length; k++) {
                if (classArray[k] == PieContextMenu.menuClassName && menus[i].id) {
                    PieContextMenu.initMenu(menus[i].id);
                }
            }
        }

        PieContextMenu.initEvents();

    },


    // private method.
    initMenu : function (menuId) {

        var list = document.getElementById(menuId);
        list.style.position = "absolute";
        list.style.margin = "0px";
        list.style.padding = "0px";
        list.style.listStyleType = "none";

        var items = list.getElementsByTagName('li');
        var images = list.getElementsByTagName('img');

        for(var i=0; i<images.length; i++) {
            images[i].style.border = "0px";
            if (document.all && document.getElementById && !window.opera) {
                images[i].style.filter = 'progid:DXImageTransform.Microsoft.AlphaImageLoader(src="icon-bg.png", sizingMethod="crop")';
            } else {
                images[i].style.background = "url(icon-bg.png)";
            }
        }

        var step = (2.0 * Math.PI) / (1.0 * (items.length));
        var rotation = (90 / 180) * Math.PI;
        var radius = Math.sqrt(this.itemWidth) * Math.sqrt(items.length) * 2.5;

        for(var i=0; i<items.length; i++) {
            var x = Math.cos(i*step - rotation) * radius - (this.itemWidth / 2);
            var y = Math.sin(i*step - rotation) * radius - (this.itemHeight / 2);
            items[i].style.position = "absolute";
            items[i].style.display = "block";
            items[i].style.fontSize = "0px";
            items[i].style.left = Math.round(x) + "px";
            items[i].style.top = Math.round(y) + "px";
        }

    },


    // public method. Attaches context menus to specific class names
    attach : function (classNames, menuId) {
        if (typeof(classNames) == "string") {
            PieContextMenu.menus[classNames] = menuId;
        }

        if (typeof(classNames) == "object") {
            for (x = 0; x < classNames.length; x++) {
                PieContextMenu.menus[classNames[x]] = menuId;
            }
        }

    },


    // public method. Sets up events
    initEvents : function () {

        if ( PieContextMenu.IE || PieContextMenu.FF ) {
            document.oncontextmenu = PieContextMenu.show;
            document.onclick = PieContextMenu.hide;

        }

    },


    // private method. Shows context menu
    show : function (e) {
        PieContextMenu.hide();
        var menuElementId = PieContextMenu.getMenuElementId(e);
        if (menuElementId) {
            var m = PieContextMenu.getMousePosition(e);
            var s = PieContextMenu.getScrollPosition(e);
            PieContextMenu.menuElement = document.getElementById(menuElementId);
            PieContextMenu.menuElement.style.left = m.x + (s.x+330) + 'px';
            PieContextMenu.menuElement.style.top = m.y + (s.y+300) + 'px';
            PieContextMenu.menuElement.style.display = 'block';
            return false;
        }

        return false;

    },


    // private method. Hides context menu
    hide : function () {

        if (PieContextMenu.menuElement) {
            PieContextMenu.menuElement.style.display = 'none';
            PieContextMenu.menuElement = null;
        }

    },


    // private method. Get which context menu to show
    getMenuElementId : function (e) {

        if (PieContextMenu.IE) {
            PieContextMenu.attachedElement = event.srcElement;
        } else {
            PieContextMenu.attachedElement = e.target;
        }

        while(PieContextMenu.attachedElement != null) {
            var className = PieContextMenu.attachedElement.className;
            if (typeof(className) != "undefined") {
                className = className.replace(/^\s+/g, "").replace(/\s+$/g, "")
                var classArray = className.split(/[ ]+/g);

                for (i = 0; i < classArray.length; i++) {
                    if (PieContextMenu.menus[classArray[i]]) {
                        return PieContextMenu.menus[classArray[i]];
                    }
                }
            }

            if (PieContextMenu.IE) {
                PieContextMenu.attachedElement = PieContextMenu.attachedElement.parentElement;
            } else {
                PieContextMenu.attachedElement = PieContextMenu.attachedElement.parentNode;
            }
        }

        return null;

    },


    // private method. Returns mouse position
    getMousePosition : function (e) {

        e = e ? e : window.event;
        var position = {
            'x' : e.clientX,
            'y' : e.clientY
        }

        return position;

    },


    // private method. Get document scroll position
    getScrollPosition : function () {

        var x = 0;
        var y = 0;

        if( typeof( window.pageYOffset ) == 'number' ) {
            x = window.pageXOffset;
            y = window.pageYOffset;
        } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
            x = document.documentElement.scrollLeft;
            y = document.documentElement.scrollTop;
        } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
            x = document.body.scrollLeft;
            y = document.body.scrollTop;
        }

        var position = {
            'x' : x,
            'y' : y
        }

        return position;

    }

}

PieContextMenu.init();
