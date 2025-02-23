import{e as $,al as E,a as x,p as M,B as T,m as i,W as b,o as f,N as c,O as s,Z as h,h as W,U as g,V as _,v as e,k as L,j as U,l as n,$ as q,aa as y,a7 as F,_ as A}from"./vue-DkQzphiS.js";import{c as K,e as O,x as R,_ as Z}from"./index-B0iOz79E.js";import{F as G}from"./index-tQazVPhs.js";import{b as V}from"./validate-DcgMk89l.js";const H="/admin/user.MoneyLog/";function J(v){return K({url:H+"add",method:"get",params:{userId:v}})}const Q={class:"title"},X=$({__name:"popupForm",setup(v){const k=O(),{t}=R.useI18n(),l=E("baTable"),w=x({user_id:[V({name:"required",message:t("Please select field",{field:t("user.moneyLog.User")})})],money:[V({name:"required",title:t("user.moneyLog.Change amount")}),{validator:(m,o,u)=>!o||parseFloat(o)==0?u(new Error(t("Please enter the correct field",{field:t("user.moneyLog.Change amount")}))):u(),trigger:"blur"}],memo:[V({name:"required",title:t("user.moneyLog.remarks")})]}),p=M(),r=x({userInfo:{},after:0}),I=()=>{!l.form.items.user_id||parseInt(l.form.items.user_id)<=0||J(l.form.items.user_id).then(m=>{r.userInfo=m.data.user,r.after=m.data.user.money})},S=m=>{if(!r.userInfo||typeof r.userInfo>"u"){r.after=0;return}let o=m==""?0:parseFloat(m);r.after=parseFloat((parseFloat(r.userInfo.money)+o).toFixed(2))};return T(()=>l.form.operate,m=>{m&&I()}),(m,o)=>{const u=i("el-input"),d=i("el-form-item"),P=i("el-form"),B=i("el-scrollbar"),C=i("el-button"),j=i("el-dialog"),z=b("drag"),D=b("zoom"),N=b("blur");return f(),c(j,{class:"ba-operate-dialog","close-on-click-modal":!1,"model-value":["Add","Edit"].includes(e(l).form.operate),onClose:e(l).toggleForm},{header:s(()=>[h((f(),W("div",Q,[g(_(e(l).form.operate?e(t)(e(l).form.operate):""),1)])),[[z,[".ba-operate-dialog",".el-dialog__header"]],[D,".ba-operate-dialog"]])]),footer:s(()=>[L("div",{style:U("width: calc(100% - "+e(l).form.labelWidth/1.8+"px)")},[n(C,{onClick:o[10]||(o[10]=a=>e(l).toggleForm(""))},{default:s(()=>[g(_(e(t)("Cancel")),1)]),_:1}),h((f(),c(C,{loading:e(l).form.submitLoading,onClick:o[11]||(o[11]=a=>e(l).onSubmit(p.value)),type:"primary"},{default:s(()=>[g(_(e(l).form.operateIds.length>1?e(t)("Save and edit next item"):e(t)("Save")),1)]),_:1},8,["loading"])),[[N]])],4)]),default:s(()=>[n(B,{class:"ba-table-form-scrollbar"},{default:s(()=>[L("div",{class:q(["ba-operate-form","ba-"+e(l).form.operate+"-form"]),style:U(e(k).layout.shrink?"":"width: calc(100% - "+e(l).form.labelWidth/2+"px)")},[e(l).form.loading?A("",!0):(f(),c(P,{key:0,ref_key:"formRef",ref:p,onKeyup:o[9]||(o[9]=y(a=>e(l).onSubmit(p.value),["enter"])),model:e(l).form.items,"label-position":e(k).layout.shrink?"top":"right","label-width":e(l).form.labelWidth+"px",rules:w},{default:s(()=>[n(G,{type:"remoteSelect",prop:"user_id",label:e(t)("user.moneyLog.User ID"),modelValue:e(l).form.items.user_id,"onUpdate:modelValue":o[0]||(o[0]=a=>e(l).form.items.user_id=a),placeholder:e(t)("Click select"),"input-attr":{pk:"user.id",field:"nickname_text",remoteUrl:"/admin/user.User/index",onChange:I}},null,8,["label","modelValue","placeholder","input-attr"]),n(d,{label:e(t)("user.moneyLog.User name")},{default:s(()=>[n(u,{modelValue:r.userInfo.username,"onUpdate:modelValue":o[1]||(o[1]=a=>r.userInfo.username=a),disabled:""},null,8,["modelValue"])]),_:1},8,["label"]),n(d,{label:e(t)("user.moneyLog.User nickname")},{default:s(()=>[n(u,{modelValue:r.userInfo.nickname,"onUpdate:modelValue":o[2]||(o[2]=a=>r.userInfo.nickname=a),disabled:""},null,8,["modelValue"])]),_:1},8,["label"]),n(d,{label:e(t)("user.moneyLog.Current balance")},{default:s(()=>[n(u,{modelValue:r.userInfo.money,"onUpdate:modelValue":o[3]||(o[3]=a=>r.userInfo.money=a),disabled:"",type:"number"},null,8,["modelValue"])]),_:1},8,["label"]),n(d,{prop:"money",label:e(t)("user.moneyLog.Change amount")},{default:s(()=>[n(u,{onInput:S,modelValue:e(l).form.items.money,"onUpdate:modelValue":o[4]||(o[4]=a=>e(l).form.items.money=a),type:"number",placeholder:e(t)("user.moneyLog.Please enter the balance change amount")},null,8,["modelValue","placeholder"])]),_:1},8,["label"]),n(d,{label:e(t)("user.moneyLog.Balance after change")},{default:s(()=>[n(u,{modelValue:r.after,"onUpdate:modelValue":o[5]||(o[5]=a=>r.after=a),type:"number",disabled:""},null,8,["modelValue"])]),_:1},8,["label"]),n(d,{prop:"memo",label:e(t)("user.moneyLog.remarks")},{default:s(()=>[n(u,{onKeyup:[o[6]||(o[6]=y(F(()=>{},["stop"]),["enter"])),o[7]||(o[7]=y(F(a=>e(l).onSubmit(p.value),["ctrl"]),["enter"]))],modelValue:e(l).form.items.memo,"onUpdate:modelValue":o[8]||(o[8]=a=>e(l).form.items.memo=a),type:"textarea",placeholder:e(t)("user.moneyLog.Please enter change remarks / description")},null,8,["modelValue","placeholder"])]),_:1},8,["label"])]),_:1},8,["model","label-position","label-width","rules"]))],6)]),_:1})]),_:1},8,["model-value","onClose"])}}}),Y=Z(X,[["__scopeId","data-v-77b66c54"]]),ae=Object.freeze(Object.defineProperty({__proto__:null,default:Y},Symbol.toStringTag,{value:"Module"}));export{Y as P,J as a,ae as p,H as u};
