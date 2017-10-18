/**
 * 
 * overlay:简单遮罩
 * 
 */

;(function($) {

    // 默认设置
    var  defaults = {
            html: '<div class="loading"></div>数据加载中 ', //html为遮罩层的内容
            duration: 'fast', //遮罩层jquery动画的速度
            fontColor: '#333',//字体颜色
            textAlign: 'center', //对齐
            verticalMiddle: true, //居中
            bgColor: ["#eeeeee",0.2], //背景色和透明度
            direction: "top", //动画的方向
            height: '100%' //高度
        };

    function OverLay(element, options,index) {
        this.element = element;
        this.settings = $.extend({}, defaults, options);
        this._defaults = defaults;
        this.layIn();
        this.index = index;
    }

    OverLay.prototype = {
        layIn: function() {
            var that = this,$element = this.element;
            $overlayContainer = that.createContainer($element);           
            that.overlayContainer = $overlayContainer;
           
            var $overlay = $overlayContainer.find('.nin-overlay');
            if (!$overlay.length) {
                $overlay = that.createOverlay(that, that.settings.direction, $element);
                $overlayContainer.html($overlay);
            }
            that.slideIn(that, $overlay);
        },
        layOut: function() {
            var that = this,$element = this.element;
            that.removeOverlay(that, that.overlayContainer, that.settings.direction);
            return true;
        },
        createContainer: function($element) {
            var top = $element.offset().top,
                left = $element.offset().left,
                width = $element.outerWidth(),
                height = $element.outerHeight();
            zIndex = $element.css("z-index");
            var $overlayContainer = $('<div>', {
                "class": 'nin-container'
            }).css({
                width: width,
                height: height,
                position: 'absolute',
                overflow: 'hidden',
                top: top,
                left: left,
                borderRadius:$element.css('border-radius'),
                zIndex: zIndex == +zIndex ? (zIndex + 1) : 2020114 
            });

            $('body').append($overlayContainer);

            return $overlayContainer;
        },
        createOverlay: function(instance, direction, $element) {

            var bottom, left, $main, $overlay, content, $overcontent;
            switch (direction) {
                case "top":
                    left = 0;
                    bottom = '100%';
                    break;
                case "right":
                    left = '100%';
                    bottom = 0;
                    break;
                case "bottom":
                    left = 0;
                    bottom = '-100%';
                    break;
                case "left":
                    left = '-100%';
                    bottom = 0;
                    break;
                default:;
            };
            $main = $('<div>');
            $overlay = $('<div>', {"class": 'nin-overlay'});
            $overcontent = $('<div>', {"class": 'nin-overlay'});
            content = $('<div>').html(instance.settings.html);
            if (instance.settings.verticalMiddle) {
            	content.css({
                	position:'relative',
                	top:$element.height()/2
                });   
            }
           
            var alpha = "alpha(opacity="+instance.settings.bgColor[1]*100+")";
            $main.css({
            	 width: '100%',
                 height: instance.settings.height,
                 position: 'absolute',
                 left: left,
                 bottom: bottom
            });
            $overlay.css({
                width: '100%',
                height: '100%',
                position: 'absolute',
                left: 0,
                top: 0,
                backgroundColor: instance.settings.bgColor[0],
                filter:alpha,
            	opacity: instance.settings.bgColor[1],
            	"z-index":9999
            });
            $overcontent.css({
                width: '100%',
                height: '100%',
                position: 'absolute',
                left: 0,
                top: 0,
                display: instance.settings.verticalMiddle ? 'table' : 'inline',
                textAlign: instance.settings.textAlign,
                color: instance.settings.fontColor,
                "z-index":99999
            }).html(content);
            $main.append($overlay).append($overcontent);
            return $main;
        },
        slideIn: function(instance, $overlay) {
            $overlay.stop().animate({
                left: 0,
                bottom: 0
            }, instance.settings.duration);
        },
        removeOverlay: function(instance, $overlayContainer, direction) {
            var finalState,
                $overlay = $overlayContainer.find('.nin-overlay');
            switch (direction) {
                case "top": 
                    finalState = {
                        bottom: '100%',
                        left: 0
                    };
                    break;
                case "right": 
                    finalState = {
                        bottom: 0,
                        left: '100%'
                    };
                    break;
                case "bottom": 
                    finalState = {
                        bottom: '-100%',
                        left: 0
                    };
                    break;
                case "left":
                    finalState = {
                        bottom: 0,
                        left: '-100%'
                    };
                    break;
                default:;
            };

            $overlay.stop().animate(finalState, instance.settings.duration, function() {
                $overlayContainer.remove();
            });
        },
        resize:function(){
        	var $element = $(this.element),$overlayContainer = this.overlayContainer;
        	var top = $element.offset().top,
            left = $element.offset().left,
            width = $element.outerWidth(),
            height = $element.outerHeight();
        	$overlayContainer.css({
        		 width: width,
                 height: height,
                 top: top,
                 left: left
        	});
        }
    };
    var layarr = {},index=0;
    //显示遮罩层
    $.fn.ninLayIn = function(options) {
    	var $OverLay = $(this).data("nin_overLay");
    	if($OverLay){
    		$OverLay.layIn();
    	}else{
    		layarr['lay_'+index] = this;
    		index = index +1;
    		$(this).data("nin_overLay",new OverLay(this,options,index));
    	}
        return this;
    };
    
    //遮罩层退出
    $.fn.ninLayOut = function(options) {
        var $OverLay = $(this).data("nin_overLay");
        var index_i = $OverLay.index;
        delete layarr['lay_'+index_i];
        $OverLay && $OverLay.layOut() && $(this).data("nin_overLay",null);
        return this;
    };
    
    //窗口变化
    var has_resize = false;
    $(window).resize(function(){
    	has_resize = true;
    });
    setInterval(function(){
    	if(has_resize){
    		for(var p in layarr){
    			if(layarr[p]){
    				var $OverLay = $(layarr[p]).data("nin_overLay");
    				$OverLay && $OverLay.resize();
    			}
    		}
    		has_resize = false;
    	}
    },100)
})(jQuery);