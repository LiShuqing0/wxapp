var CUES = {
    tip:function(options){
        var msg = options.msg;
        var type = options.type?options.type:'tip';
        var time = options.time?options.time:1000;
        var elma = this.createdom({"tag":"div","classname":"tippop","msg":'<div class="text '+type+'">'+msg+'</div></div>'});
        document.body.appendChild(elma);
        setTimeout(function(){
            elma.style.opacity = 0;
            elma.style.webkitTransition = 'all 1.5s';
            setTimeout(function(){
                options.callback && options.callback();
                elma.remove();
            },1000);
        },time);
    },
    alert:function(options){
        var msg = options.msg;
        var elma = this.createdom({"tag":"div","classname":"tippop_alert"});
        var elmb = this.createdom({"tag":"p","classname":"tippop_alert_t","msg":options.msg});
        var elmc = this.createdom({"tag":"a","classname":"tippop_alert_b","msg":"确定"});
        elma.appendChild(elmb),elma.appendChild(elmc);
        document.body.appendChild(elma);

        var elm_bg = this.createdom({"tag":"div","classname":"tippop_bg"});
        document.body.appendChild(elm_bg);

        elmc.addEventListener('click',function(){
            elm_bg.remove();
            elma.remove();
            options.callback && options.callback();
        },false);
    },
    confirm:function(options){
        var msg = options.msg;
        var elma = this.createdom({"tag":"div","classname":"tippop_alert"});
        var elmb = this.createdom({"tag":"p","classname":"tippop_alert_t","msg":options.msg});
        var elmc = this.createdom({"tag":"p","classname":"tippop_alert_b"});
        var a_cal = this.createdom({"tag":"a","classname":"tippop_cancel_btn","msg":"取消"});
        var a_sure = this.createdom({"tag":"a","classname":"tippop_confirm_btn","msg":"确定"});
        elmc.appendChild(a_cal),elmc.appendChild(a_sure);
        elma.appendChild(elmb),elma.appendChild(elmc);
        document.body.appendChild(elma);
        var elm_bg = this.createdom({"tag":"div","classname":"tippop_bg"});
        document.body.appendChild(elm_bg);
        a_cal.addEventListener('click',function(){
            elm_bg.remove();
            elma.remove();
            options.callback && options.callback(0);
        },false);
        a_sure.addEventListener('click',function(){
            elm_bg.remove();
            elma.remove();
            options.callback && options.callback(1);
        },false);
    },
    input:function(options){
        var msg = options.msg;
        var elma = this.createdom({"tag":"div","classname":"tippop_alert"});
        var elmb = this.createdom({"tag":"p","classname":"tippop_input_t","msg":options.msg});
        var input = this.createdom({"tag":"input","classname":"input"});
        var elmm = this.createdom({"tag":"p","classname":"tippop_input_m"});
        var elmc = this.createdom({"tag":"p","classname":"tippop_alert_b"});
        var a_cal = this.createdom({"tag":"a","classname":"tippop_cancel_btn","msg":"取消"});
        var a_sure = this.createdom({"tag":"a","classname":"tippop_confirm_btn","msg":options.suretext?options.suretext:"确定"});
        elmc.appendChild(a_cal),elmc.appendChild(a_sure);
        input.setAttribute('placeholder',options.placeholder?options.placeholder:'');
        elmm.appendChild(input);
        elma.appendChild(elmb),elma.appendChild(elmm),elma.appendChild(elmc);
        document.body.appendChild(elma);
        var elm_bg = this.createdom({"tag":"div","classname":"tippop_bg"});
        document.body.appendChild(elm_bg);
        a_cal.addEventListener('click',function(){
            elm_bg.remove();
            elma.remove();
            options.callback && options.callback(false, 0);
        },false);
        a_sure.addEventListener('click',function(){
            elm_bg.remove();
            elma.remove();
            options.callback && options.callback(true, input.value);
        },false);
    },
    createdom:function(options){
        var dom = document.createElement(options.tag);
        dom.className = options.classname;
        if(options.msg){
            dom.innerHTML = options.msg;
        }
        return dom;
    }
};
function getRequest(){
    var url = window.location.search,
        theRequest = {},
        str = '',
        para = [];
    if (url.indexOf("?") != -1) {
        str = url.substr(1);
        strs = str.split("&");
        for(var i = 0, len = strs.length; i < len; i ++) {
            para = strs[i].split("=");
            theRequest[para[0]] = decodeURIComponent( (para.length>=2)?para[1]:"");
        }
    }
    return theRequest;
};


/*update  dateselect.JS - 2017-12-9
 * By ShaoHua zhang
 * 577056210@qq.com  (low)
 * freedom front-end engineer */

var dateselect = function(options){
    this.opt = options;
    this.setting();
}
dateselect.prototype.setting = function(){
    var opt = this.opt;
    
    var _this = this;
    this.targets = opt.targets;
    // this.targetarr =  {};

    this.outer = this.createdom({"tag":"div","classname":"dateselect_input_box"});
    this.timegroups = opt.timegroups||["y","m","d","h","i","s"];
    this.unit = opt.unit||40;
    this.format = opt.format||'y/m/d h:m';
    this.selected = opt.selected?opt.selected:null;
    this.empty = opt.empty?opt.empty:null;
    document.body.appendChild(this.outer);
    this.setattr(this.outer,[["id","dateselect_input_box"]]);
    this.render_input();

    for(var i=0,len = this.targets.length;i<len;i++){
        (function(){

            var v = _this.targets[i],obj = {};
            obj.target = _this.targets[i];
            obj.nowtime = opt.defaultdate?new Date(opt.defaultdate.replace(/\-/ig,'/')):new Date();
            obj.nowtime = _this.inittime(obj.nowtime);
            
            _this.bindEvent_input_click(obj);
           
            // _this.targetarr[v.target] = obj;

        })();
    };
    this.bindEvent_input_cus();
};

dateselect.prototype.createdom = function(options){
    var dom = document.createElement(options.tag);
    dom.className = options.classname;
    if(options.msg){
        dom.innerHTML = options.msg;
    }
    return dom;
};

dateselect.prototype.setattr = function(dom,attrs){
    for(k in attrs){
        dom.setAttribute([attrs[k][0]],attrs[k][1]);
    }
};

dateselect.prototype.render_input = function(){
    this.outer.innerHTML = '<div class="dateselect_input"><div class="dpls"></div><p class="dp-btns"><a href="javascript:;" class="dp-btn dp-empty">清空</a><a href="javascript:;" class="dp-btn dp-cal">取消</a><a href="javascript:;" class="dp-btn dp-sure">确定</a></p></div>';
    this.dpls = this.outer.getElementsByClassName("dpls")[0];
    this.dp_cal = this.outer.getElementsByClassName("dp-cal")[0];
    this.dp_empty = this.outer.getElementsByClassName("dp-empty")[0];
    this.dp_sure = this.outer.getElementsByClassName("dp-sure")[0];
    this.dpls.className = "dpls dpls"+this.timegroups.length;
    this.selects = {};
    for(var i=0,len = this.timegroups.length;i<len;i++){
        this.createselect(this.timegroups[i]);
    };
};
dateselect.prototype.createselect = function(type){
    var ul = this.createdom({"tag":"ul","classname":"dp-select-ul"}),
        box = this.createdom({"tag":"div","classname":"dp-select"}),
        str = '';
    if(type=='y'){
        for(var i=2000;i<2030;i++){
            str += '<li class="dp-option">'+i+'年</li>';
        };
    }else if(type=='m'){
        for(var i=1;i<13;i++){
            str += '<li class="dp-option">'+(i<10?'0'+i:i)+'月</li>';
        };
    }else if(type=='d'){
        for(var i=1;i<32;i++){
            str += '<li class="dp-option">'+(i<10?'0'+i:i)+'日</li>';
        };
    }else if(type=='h'){
        for(var i=0;i<24;i++){
            str += '<li class="dp-option">'+(i<10?'0'+i:i)+'时</li>';
        };
    }else if(type=='i'){
        for(var i=0;i<60;i+=5){
            str += '<li class="dp-option">'+(i<10?'0'+i:i)+'分</li>';
        };
    }else if(type=='s'){
        for(var i=0;i<60;i+=5){
            str += '<li class="dp-option">'+(i<10?'0'+i:i)+'秒</li>';
        };
    };
    ul.innerHTML = str;
    box.appendChild(ul);
    this.selects[type] = {};
    this.selects[type].box = box;
    this.selects[type].ul = ul;
    if(type=='d'){
        this.selects[type].li = ul.getElementsByClassName("dp-option");
    }
    this.dpls.appendChild(this.selects[type].box);
    this.bindEvent_input(type,this.selects[type]);
};
dateselect.prototype.bindEvent_input = function(type,obj){
    var _this = this,
        box = obj.box,
        ul = obj.ul,
        unit = this.unit,
        twou = unit*2;
    obj.y = 0;
    obj.ly = 0;
    box.addEventListener('touchstart',function(event){
        var touches = event.targetTouches;
        obj.fy = touches[0].pageY;
    },false);
    box.addEventListener('touchmove',function(event){
        var touches = event.targetTouches;
            y =  touches[0].pageY -  obj.fy;
        obj.ly = touches[0].pageY;
        ul.style.cssText = "-webkit-transform:translate3d(0,"+(obj.y+y)+"px,0);transform:translate3d(0,"+(obj.y+y)+"px,0)";
        event.preventDefault();
    },false)
    box.addEventListener('touchend',function(event){
        if(obj.ly==0){ return false;}
        obj.y = obj.y + obj.ly - obj.fy;
        obj.y = Math.round(obj.y/unit)*unit;
        if(type=='y'){
            if(obj.y<-(27*unit)){obj.y = -(27*unit);}else if(obj.y>twou){obj.y = twou;};
            obj.value = 2002 - obj.y/unit;
            _this.changeym();
        }else if(type=='m'){
            if(obj.y<-(9*unit)){obj.y = -(9*unit);}else if(obj.y>twou){obj.y = twou;};
            obj.value = 3 - obj.y/unit;
            _this.changeym();
        }else if(type=='d'){
            if(obj.y<-obj.maxy){obj.y = -obj.maxy;}else if(obj.y>twou){obj.y = twou;};
            obj.value = 3 - obj.y/unit;
        }else if(type=='h'){
            if(obj.y<-(21*unit)){obj.y = -(21*unit);}else if(obj.y>twou){obj.y = twou;};
            obj.value = 2 - obj.y/unit;
        }else if(type=='i'){
            if(obj.y<-(9*unit)){obj.y = -(9*unit);}else if(obj.y>twou){obj.y = twou;};
            obj.value = 10 - obj.y*5/unit;
        }else if(type=='s'){
            if(obj.y<-(9*unit)){obj.y = -(9*unit);}else if(obj.y>twou){obj.y = twou;};
            obj.value = 10 - obj.y*5/unit;
        };
        ul.style.cssText = "-webkit-transform:translate3d(0,"+(obj.y)+"px,0);transform:translate3d(0,"+(obj.y)+"px,0);-webkit-transition: -webkit-transform 0.4s;transition:transform 0.4s;"
        obj.ly = 0;
    },false);
};
dateselect.prototype.changeym = function(){
    var dmax = 28,
        valy = this.selects['y'].value,
        valm = this.selects['m'].value,
        sd = this.selects['d'],
        vald = sd.value,
        dul = sd.ul,
        dlis = sd.li,
        unit = this.unit;
    if(valm==2){
        dlis[29].style.opacity = 0;
        dlis[30].style.opacity = 0;
        if(valy%4==0){
            dlis[28].style.opacity = 1;
            dmax = 26;
        }else{
            dlis[28].style.opacity = 0;
            dmax = 25;
        };
    }else if(valm==4 || valm==6 || valm==9 || valm==11){
        dlis[28].style.opacity = 1;
        dlis[29].style.opacity = 1;
        dlis[30].style.opacity = 0;
        dmax = 27;
    }else{
        dlis[28].style.opacity = 1;
        dlis[29].style.opacity = 1;
        dlis[30].style.opacity = 1;
    };
    sd.maxy = dmax*unit;
    if(vald>dmax){
        sd.value = dmax;
        sd.y = -sd.maxy;
        dul.style.cssText = "-webkit-transform:translate3d(0,-"+(dmax*unit)+"px,0);transform:translate3d(0,-"+(dmax*unit)+"px,0)";
    };
};
dateselect.prototype.bindEvent_input_click = function(obj){
    var _this = this,
        unit = this.unit,
        outer = this.outer,
        target = obj.target,
        timegroups = _this.timegroups;
    obj.target.addEventListener('click',function(){
        console.log(5,obj)
        _this.obj = obj;
        _this.nowtime = target.value?new Date(target.value.replace(/\-/ig,'/')):new Date();
        _this.nowtime = _this.inittime(_this.nowtime);
        for(var i=0,len = timegroups.length;i<len;i++){
            var type = timegroups[i];
            var s = _this.selects[type];
            s.box.style.display = "block";
            if(type=='y'){
                s.value = _this.nowtime.getFullYear();
                s.y = (2002 - _this.nowtime.getFullYear())*unit
            }else if(type=='m'){
                s.value = _this.nowtime.getMonth()+1;
                s.y = (2 - _this.nowtime.getMonth())*unit
            }else if(type=='d'){
                s.value = _this.nowtime.getDate();
                s.y = (3 - _this.nowtime.getDate())*unit
            }else if(type=='h'){
                s.value = _this.nowtime.getHours();
                s.y = (2 - _this.nowtime.getHours())*unit
            }else if(type=='i'){
                s.value = _this.nowtime.getMinutes();
                s.y = (2 - _this.nowtime.getMinutes()/5)*unit
            }else if(type=='s'){
                s.value = _this.nowtime.getSeconds();
                s.y = (2 - _this.nowtime.getSeconds()/5)*unit
            };
            s.ul.style.cssText = "-webkit-transform:translate3d(0,"+(s.y)+"px,0);transform:translate3d(0,"+(s.y)+"px,0);"
        };
        outer.style.display = "block";
    },false);
    
};

dateselect.prototype.timeformat = function(time,target,format){
    format = format.replace("y",time.getFullYear());
    format = format.replace("m",(time.getMonth()+1)<10?'0'+(time.getMonth()+1):(time.getMonth()+1));
    format = format.replace("d",time.getDate()<10?'0'+time.getDate():time.getDate());
    format = format.replace("h",time.getHours()<10?'0'+time.getHours():time.getHours());
    format = format.replace("i",time.getMinutes()<10?'0'+time.getMinutes():time.getMinutes());
    format = format.replace("s",time.getSeconds()<10?'0'+time.getSeconds():time.getSeconds());
    target.value = format ;
};
dateselect.prototype.bindEvent_input_cus = function(){
    var _this = this,
        outer = this.outer;
    this.dp_cal.addEventListener('click',function(){
        outer.style.display = "none";
    },false);
    this.dp_empty.addEventListener('click',function(){
        if(_this.empty){
            _this.empty(_this.obj.target);
            outer.style.display = "none";
        };
    },false)
    this.dp_sure.addEventListener('click',function(){
        var v = _this.format,
            timegroups = _this.timegroups;

            // console.log(timegroups)
        for(var i=0,len = timegroups.length;i<len;i++){
            var type = timegroups[i];
            var sel = _this.selects[type], vv = sel.value<10?'0'+sel.value:sel.value;
            v = v.replace(timegroups[i],vv);
        };
        _this.obj.target.value = v;
        _this.obj.target.innerHTML = v;
        outer.style.display = 'none';
        if(_this.selected){
            _this.selected(_this.obj.target,new Date(v.replace(/\-/ig,'/')),v)
        }
    },false)
};
dateselect.prototype.inittime = function(time){
    var i = parseInt(time.getMinutes()/5)*5;
    var s = parseInt(time.getSeconds()/5)*5;
    return new Date(time.getFullYear()+'/'+(time.getMonth()+1)+'/'+time.getDate()+' '+time.getHours()+':'+i+':'+s);
};

function botmore(num,callback){
    this.num = num;
    this.callback = callback;
    this.bindevent();
    this.stop = true;
};
botmore.prototype = {
    bindevent:function(){
        var _this = this;
        var timer = '',
            body = document.body||document.documentElement,
            win_h = body.offsetHeight;

            this.bodyscroll = function(event){
                clearTimeout(timer);
                if(_this.stop){return false;};
                timer = setTimeout(function(){
                    var scrolltop=document.documentElement.scrollTop||document.body.scrollTop,
                        bodyh = body.offsetHeight;
                    if(scrolltop+win_h+_this.num>bodyh){
                        _this.callback();
                    }
                    
                },100);
            };
            this.bindscroll();
    },
    bindscroll:function(){
        var _this = this;
        window.addEventListener('scroll', _this.bodyscroll,false);
    },
    unbindscroll:function(){
         var _this = this;
         window.removeEventListener('scroll',_this.bodyscroll,false);
    }
};

function imgsee(opt){
    var dom = $('<div class="seeimgbox">\
        <a href="javascript:;" class="J_close close">关闭</a>\
        <p class="num"><span class="cur">1</span>/<span class="tol">0</span></p>\
        <p class="imgbox"></p>\
        <p class="botdo"><a href="javascript:;" class="J_minus bdls">-</a><a href="javascript:;" class="J_iback bdls">还原</a><a href="javascript:;" class="J_down bdls">下载</a><a href="javascript:;" class="J_plus bdls">+</a></p>\
    </div>');

    $('body').append(dom);

    var cur = dom.find('.cur').eq(0),
        tol = dom.find('.tol').eq(0),
        J_close = dom.find('.J_close'),
        J_minus = dom.find('.J_minus').eq(0)[0],
        J_iback = dom.find('.J_iback').eq(0)[0],
        J_down = dom.find('.J_down').eq(0)[0],
        J_plus = dom.find('.J_plus').eq(0)[0],
        imgbox = dom.find('.imgbox').eq(0)[0];

    tol.html(opt.imgs.length);

    var str = '',list = opt.imgs,len = list.length;
    for(var i=0;i<len;i++){
        str += '<a href="javascript:;" class="sibox"><span class="mbox"><img src="'+list[i]+'" class="siimg"></span></a>';
    };
    imgbox.innerHTML = str;

    var imgs = imgbox.getElementsByClassName('sibox'),
        mbox = imgbox.getElementsByClassName('mbox'),
        imglen = imgs.length,
        imgmaxlen = imglen - 1,
        width = window.innerWidth,
        fx = 0,
        lx = 0,
        ox = 0,
        oy = 0,
        omx = 0,
        omy = 0,
        lt = null,
        dataindex = 0,
        scale = 1,
        mobj = imgs[0],
        isback = false,
        figs = [];

    imgbox.addEventListener('touchstart',function(event){
        var touches = event.targetTouches;
        if(isback){
            omx = touches[0].pageX;
            omy = touches[0].pageY;
        }else{
            for(var i=0;i<3;i++){
                if(figs[i]) figs[i].style.webkitTransition = "all 0s";
            };
            fx = touches[0].pageX;
        }
    },false);
    imgbox.addEventListener('touchmove',function(event){
        var touches = event.targetTouches;
        if(isback){
            lt =touches[0];
            var cx = lt.pageX - omx,
                cy = lt.pageY - omy;
            mobj.style.webkitTransform = 'translateZ(0) translate('+(ox+cx)+'px,'+(oy+cy)+'px) scale('+scale+','+scale+')';
        }else{
            lx = touches[0].pageX;
            var cy =  lx - fx;
            for(var i=0;i<3;i++){
                if(figs[i]) figs[i].style.webkitTransform = 'translateZ(0) translateX('+((i-1)*width+cy)+'px)';
            };
        }
        event.preventDefault();
    },false);

    imgbox.addEventListener('touchend',function(event){
        if(isback){
            if(lt){
                ox = ox + lt.pageX - omx;
                oy = oy + lt.pageY - omy;
                lt = null;
            }
        }else{
            if(lx==0){
                return false;
            };
            if(lx-fx<= -(width/5)){//left
                dataindex++;
                if(dataindex>imgmaxlen){
                    dataindex--;
                }else{
                    figs.shift();
                    var o = (dataindex+1)>imgmaxlen?null:imgs[dataindex+1];
                    if(o) o.style.webkitTransition = "all 0s";
                    if(o) o.style.webkitTransform = 'translateZ(0) translateX('+width+'px)';
                    figs.push(o);
                };
            }else if(lx-fx>=width/5){
                dataindex--;
                if(dataindex<0){
                    dataindex = 0;
                }else{
                    figs.pop();
                    figs.reverse();
                    var o = (dataindex-1)<0?null:imgs[dataindex-1];
                    if(o) o.style.webkitTransition = "all 0s";
                    if(o) o.style.webkitTransform = 'translateZ(0) translateX(-'+width+'px)';
                    figs.push(o);
                    figs.reverse();
                };
            };
            changepo();
            goscroll();
        }

    },false);

    function goscroll(){
        setTimeout(function(){
            lx = 0;
            for(var i=0;i<3;i++){
                var v = figs[i];
                if(v){
                    v.style.webkitTransition = "all .3s";
                    v.style.webkitTransform = 'translateZ(0) translateX('+((i-1)*width)+'px)';
                }
            };
        },20);
        mobj = imgs[dataindex];
    };
    function changepo(f,t){
        cur.html(dataindex+1)
    };

    J_minus.addEventListener('click',function(){
        if(scale>1){
            scale --;
            mobj.style.webkitTransition = "all .3s";
            mobj.style.webkitTransform = 'translateZ(0) translate('+ox+'px,'+oy+'px) scale('+scale+','+scale+')';
            setTimeout(function(){
                mobj.style.webkitTransition = "all 0s";
            },350);
        }
    },false);
    J_plus.addEventListener('click',function(){
        isback = true;
        if(scale<4){
            scale ++;
            mobj.style.webkitTransition = "all .3s";
            mobj.style.webkitTransform = 'translateZ(0) translate('+ox+'px,'+oy+'px) scale('+scale+','+scale+')';
            setTimeout(function(){
                mobj.style.webkitTransition = "all 0s";
            },350);
        }
    },false);
    J_iback.addEventListener('click',function(){
        isback = false;
        scale = 1;
        ox = 0;
        oy = 0;
        lt = null;
        mobj.style.webkitTransition = "all .3s";
        mobj.style.webkitTransform = 'translateZ(0) translate(0,0) scale(1,1)';
        setTimeout(function(){
            mobj.style.webkitTransition = "all 0s";
        },350);
    },false);
    J_down.addEventListener('click',function(){
        opt.dlcallback(list[dataindex]);
    },false);
    J_close.click(function(){
        dom.fadeOut();
    });
    this.show = function(num){
        for(var i=0;i<imglen;i++){
            imgs[i].style.webkitTransform = 'translateZ(0) translateX(-'+width+'px)';
        };

        figs = [num==0?null:imgs[num-1],imgs[num],num>=imgmaxlen?null:imgs[num+1]];
        dataindex = num;
        if(figs[0]) figs[0].style.webkitTransform = 'translateZ(0) translateX(-'+width+'px)';
        if(figs[1]) figs[1].style.webkitTransform = 'translateZ(0) translateX(0)';
        if(figs[2]) figs[2].style.webkitTransform = 'translateZ(0) translateX('+width+'px)';
        mobj = imgs[num];
        dom.fadeIn();
    }
};

$('#J_back').click(function(){
    window.history.go(-1);
});

function dombotmore(elm,num,callback){
    this.elm = document.getElementById(elm);
    this.num = num;
    this.callback = callback;
    this.bindevent();
    this.stop = true;
};
dombotmore.prototype = {
    bindevent:function(){
        // console.log(this.elm.offsetHeight)
        var _this = this;
        var timer = '';

            this.domscroll = function(event){
                
                clearTimeout(timer);
                if(_this.stop){return false;};
                timer = setTimeout(function(){
                    var scrolltop=_this.elm.scrollTop,
                        scollh = _this.elm.scrollHeight,
                        dom_h = _this.elm.offsetHeight;
                    if(scrolltop+dom_h+_this.num>scollh){
                        _this.callback();
                    }
                },100);
            };
            this.bindscroll();
    },
    bindscroll:function(){
        var _this = this;
        this.elm.addEventListener('scroll', _this.domscroll,false);
    },
    unbindscroll:function(){
         var _this = this;
         this.elm.removeEventListener('scroll',_this.domscroll,false);
    }
};