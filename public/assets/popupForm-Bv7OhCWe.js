import{e as N,p as $,al as q,a as z,B as T,m as d,W as b,o as s,N as p,O as i,Z as c,h as W,U as h,V,v as e,k,j as P,l as r,$ as j,aa as v,a7 as x,_ as K}from"./vue-DkQzphiS.js";import{e as R,v as G,x as L,_ as M}from"./index-B0iOz79E.js";import{b as u,r as O}from"./validate-DcgMk89l.js";import{F as m}from"./index-tQazVPhs.js";import"./index-CJwZD0Ka.js";import"./index-DJv0ClnV.js";const Z={class:"title"},H=N({__name:"popupForm",setup(J){const _=R(),C=G(),f=$(),a=q("baTable"),{t:o}=L.useI18n(),w=z({username:[u({name:"required",title:o("auth.admin.username")}),u({name:"account"})],nickname:[u({name:"required",title:o("auth.admin.nickname")})],group_arr:[u({name:"required",message:o("Please select field",{field:o("auth.admin.grouping")})})],email:[u({name:"email",message:o("Please enter the correct field",{field:o("auth.admin.mailbox")})})],mobile:[u({name:"mobile",message:o("Please enter the correct field",{field:o("auth.admin.mobile")})})],password:[{validator:(g,l,n)=>{if(a.form.operate=="Add"){if(!l)return n(new Error(o("Please input field",{field:o("auth.admin.Password")})))}else if(!l)return n();return O(l)?n():n(new Error(o("validate.Please enter the correct password")))},trigger:"blur"}]});return T(()=>a.form.operate,g=>{w.password[0].required=g=="Add"}),(g,l)=>{const n=d("el-input"),U=d("el-form-item"),S=d("el-form"),I=d("el-scrollbar"),y=d("el-button"),A=d("el-dialog"),E=b("drag"),F=b("zoom"),B=b("loading"),D=b("blur");return s(),p(A,{class:"ba-operate-dialog","close-on-click-modal":!1,"model-value":["Add","Edit"].includes(e(a).form.operate),onClose:e(a).toggleForm,"destroy-on-close":!0},{header:i(()=>[c((s(),W("div",Z,[h(V(e(a).form.operate?e(o)(e(a).form.operate):""),1)])),[[E,[".ba-operate-dialog",".el-dialog__header"]],[F,".ba-operate-dialog"]])]),footer:i(()=>[k("div",{style:P("width: calc(100% - "+e(a).form.labelWidth/1.8+"px)")},[r(y,{onClick:l[12]||(l[12]=t=>e(a).toggleForm(""))},{default:i(()=>[h(V(e(o)("Cancel")),1)]),_:1}),c((s(),p(y,{loading:e(a).form.submitLoading,onClick:l[13]||(l[13]=t=>e(a).onSubmit(f.value)),type:"primary"},{default:i(()=>[h(V(e(a).form.operateIds&&e(a).form.operateIds.length>1?e(o)("Save and edit next item"):e(o)("Save")),1)]),_:1},8,["loading"])),[[D]])],4)]),default:i(()=>[c((s(),p(I,{class:"ba-table-form-scrollbar"},{default:i(()=>[k("div",{class:j(["ba-operate-form","ba-"+e(a).form.operate+"-form"]),style:P(e(_).layout.shrink?"":"width: calc(100% - "+e(a).form.labelWidth/2+"px)")},[e(a).form.loading?K("",!0):(s(),p(S,{key:0,ref_key:"formRef",ref:f,onKeyup:l[11]||(l[11]=v(t=>e(a).onSubmit(f.value),["enter"])),model:e(a).form.items,"label-position":e(_).layout.shrink?"top":"right","label-width":e(a).form.labelWidth+"px",rules:w},{default:i(()=>[r(m,{label:e(o)("auth.admin.username"),modelValue:e(a).form.items.username,"onUpdate:modelValue":l[0]||(l[0]=t=>e(a).form.items.username=t),type:"string",prop:"username",placeholder:e(o)("auth.admin.Administrator login")},null,8,["label","modelValue","placeholder"]),r(m,{label:e(o)("auth.admin.nickname"),modelValue:e(a).form.items.nickname,"onUpdate:modelValue":l[1]||(l[1]=t=>e(a).form.items.nickname=t),type:"string",prop:"nickname",placeholder:e(o)("Please input field",{field:e(o)("auth.admin.nickname")})},null,8,["label","modelValue","placeholder"]),(s(),p(m,{label:e(o)("auth.admin.grouping"),modelValue:e(a).form.items.group_arr,"onUpdate:modelValue":l[2]||(l[2]=t=>e(a).form.items.group_arr=t),prop:"group_arr",type:"remoteSelect",key:"group-"+e(a).form.items.id,"input-attr":{multiple:!0,params:{isTree:!0,absoluteAuth:e(C).id==e(a).form.items.id?0:1},field:"name",remoteUrl:"/admin/auth.Group/index",placeholder:e(o)("Click select")}},null,8,["label","modelValue","input-attr"])),r(m,{label:e(o)("auth.admin.head portrait"),type:"image",modelValue:e(a).form.items.avatar,"onUpdate:modelValue":l[3]||(l[3]=t=>e(a).form.items.avatar=t)},null,8,["label","modelValue"]),r(m,{label:e(o)("auth.admin.mailbox"),prop:"email",modelValue:e(a).form.items.email,"onUpdate:modelValue":l[4]||(l[4]=t=>e(a).form.items.email=t),type:"string",placeholder:e(o)("Please input field",{field:e(o)("auth.admin.mailbox")})},null,8,["label","modelValue","placeholder"]),r(m,{label:e(o)("auth.admin.mobile"),prop:"mobile",modelValue:e(a).form.items.mobile,"onUpdate:modelValue":l[5]||(l[5]=t=>e(a).form.items.mobile=t),type:"string",placeholder:e(o)("Please input field",{field:e(o)("auth.admin.mobile")})},null,8,["label","modelValue","placeholder"]),r(m,{label:e(o)("auth.admin.Password"),prop:"password",modelValue:e(a).form.items.password,"onUpdate:modelValue":l[6]||(l[6]=t=>e(a).form.items.password=t),type:"password","input-attr":{autocomplete:"new-password"},placeholder:e(a).form.operate=="Add"?e(o)("Please input field",{field:e(o)("auth.admin.Password")}):e(o)("auth.admin.Please leave blank if not modified")},null,8,["label","modelValue","placeholder"]),r(U,{prop:"motto",label:e(o)("auth.admin.Personal signature")},{default:i(()=>[r(n,{onKeyup:[l[7]||(l[7]=v(x(()=>{},["stop"]),["enter"])),l[8]||(l[8]=v(x(t=>e(a).onSubmit(f.value),["ctrl"]),["enter"]))],modelValue:e(a).form.items.motto,"onUpdate:modelValue":l[9]||(l[9]=t=>e(a).form.items.motto=t),type:"textarea",placeholder:e(o)("Please input field",{field:e(o)("auth.admin.Personal signature")})},null,8,["modelValue","placeholder"])]),_:1},8,["label"]),r(m,{label:e(o)("State"),modelValue:e(a).form.items.status,"onUpdate:modelValue":l[10]||(l[10]=t=>e(a).form.items.status=t),type:"radio","input-attr":{border:!0,content:{0:e(o)("Disable"),1:e(o)("Enable")}}},null,8,["label","modelValue","input-attr"])]),_:1},8,["model","label-position","label-width","rules"]))],6)]),_:1})),[[B,e(a).form.loading]])]),_:1},8,["model-value","onClose"])}}}),le=M(H,[["__scopeId","data-v-84e6d30c"]]);export{le as default};
