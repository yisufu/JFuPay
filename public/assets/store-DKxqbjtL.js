import{L as d,Q as u,r as f,u as n,c as o,w as m}from"./index-B0iOz79E.js";import{d as p,a as h}from"./vue-DkQzphiS.js";const s=p("baAccount",{state:()=>({id:0,username:"",nickname:"",email:"",mobile:"",avatar:"",gender:0,birthday:"",money:0,score:0,motto:"",token:"",refresh_token:""}),actions:{dataFill(e){this.$state=e},removeToken(){this.token="",this.refresh_token=""},getGenderIcon(){let e={name:"fa fa-transgender-alt",color:"var(--el-text-color-secondary)"};switch(this.gender){case 1:e={name:"fa fa-mars-stroke-v",color:"var(--el-color-primary)"};break;case 2:e={name:"fa fa-mars-stroke",color:"var(--el-color-danger)"};break}return e},setToken(e,t){const a=t=="auth"?"token":"refresh_token";this[a]=e},getToken(e="auth"){return e==="auth"?this.token:this.refresh_token},logout(){k().then(e=>{e.code==1&&(d.remove(u),f.go(0))})}},persist:{key:u}}),c="/api/user/",g="/api/common/captcha",r="/admin/module/",i="/api/v6.store/";function T(e={}){return o({url:r+"index",method:"get",params:e})}function y(e={}){const t=n();return o({url:t.apiUrl+i+"modules",method:"get",params:e})}function U(e){const t=s(),a=n();return o({url:a.apiUrl+i+"info",method:"get",params:e},{anotherToken:t.getToken("auth")})}function k(){const e=n(),t=s();return o({url:e.apiUrl+c+"logout",method:"POST",data:{refreshToken:t.getToken("refresh")}})}function A(){return n().apiUrl+g+"?server=1"}function I(e,t={}){const a=n();return o({url:a.apiUrl+c+"checkIn",data:t,method:e},{showSuccessMessage:!0})}function S(){const e=s(),t=n();return o({url:t.apiUrl+c+"info",method:"get"},{anotherToken:e.getToken("auth")})}function v(e={}){const t=s(),a=n();return o({url:a.apiUrl+i+"order",method:"post",params:e},{anotherToken:t.getToken("auth")})}function w(e,t){const a=s(),l=n();return o({url:l.apiUrl+i+"pay",method:"post",params:{order_id:e,pay_type:t}},{anotherToken:a.getToken("auth"),showSuccessMessage:!0})}function M(e){const t=s(),a=n();return o({url:a.apiUrl+"/api/pay/check",method:"get",params:{sn:e}},{anotherToken:t.getToken("auth"),showCodeMessage:!1})}function x(e){return o({url:r+"state",method:"get",params:{uid:e}})}function _(e,t,a={}){const l=s();return o({url:r+"install",method:"post",params:{uid:e,orderId:t,token:l.getToken("auth")},data:{extend:a},timeout:3e3*10},{showCodeMessage:!1})}function L(e,t,a={}){const l=s();return o({url:r+"update",method:"POST",params:{uid:e,orderId:t,token:l.getToken("auth")},data:{extend:a},timeout:3e3*10})}function O(e){return o({url:r+"uninstall",method:"post",params:{uid:e}},{showSuccessMessage:!0})}function P(e){return o({url:r+"changeState",method:"post",data:e},{showCodeMessage:!1})}function q(e){return o({url:r+"dependentInstallComplete",method:"post",params:{uid:e}})}function B(e){const t=s();return o({url:r+"upload",method:"post",params:{file:e,token:t.getToken("auth")}})}const D=h({loading:{buy:!1,table:!0,common:!1,install:!1,goodsInfo:!1},dialog:{buy:!1,pay:!1,common:!1,goodsInfo:!1,baAccount:!1},table:{remark:"",modules:[],modulesEbak:[],category:[],onlyLocal:!1,indexLoaded:!1,params:{quickSearch:"",activeTab:"all"}},payInfo:{},goodsInfo:{},buy:{info:{},renew:!1,agreement:!0},common:{uid:"",moduleState:0,quickClose:!1,type:"loading",dialogTitle:"",fileConflict:[],dependConflict:[],loadingTitle:"init",loadingComponentKey:m(),waitInstallDepend:[],dependInstallState:"none",disableConflictFile:[],disableDependConflict:[],disableParams:{},payType:"wx"},sysVersion:"",installedModule:[],installedModuleUids:[]});export{U as a,A as b,I as c,v as d,M as e,_ as f,x as g,P as h,T as i,q as j,B as k,O as l,y as m,L as n,S as o,w as p,D as s,s as u};
