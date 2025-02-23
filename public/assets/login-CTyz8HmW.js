import{o as f,h as C,e as ne,M as se,a0 as de,p as E,a as S,z as ue,a9 as ce,m as s,l as r,O as t,v as l,k as M,V as u,aa as B,N as v,U as p,_}from"./vue-DkQzphiS.js";import{H as me,F as fe}from"./footer-CdJz3Gg6.js";import{_ as A,x as pe,b as ge,u as we,a as be,w as ve,i as _e,C as W,D as he,E as ye,F as K,G as j}from"./index-B0iOz79E.js";import{b as m,v as Ve}from"./validate-DcgMk89l.js";import{c as x}from"./index-C8IJs60o.js";import"./darkSwitch-CvLiTjG4.js";import"./router-CW6Sc17-.js";import"./useDark-PbmN5N1b.js";function Ce(){return new Promise(P=>P(!1))}const Pe={},ke={class:"login-footer-buried-point"};function Fe(P,k){return f(),C("div",ke)}const Re=A(Pe,[["render",Fe]]),Se={class:"login"},xe={key:0,class:"login-box"},ze={class:"login-title"},Le={key:4,class:"form-footer"},Te={class:"retrieve-password-form"},Ie=ne({__name:"login",setup(P){let k;const{t:a}=pe.useI18n(),z=se(),H=de(),G=ge(),O=we(),J=be(),h=E(),y=E(),e=S({form:{tab:"login",email:"",mobile:"",username:"",password:"",captcha:"",keep:!1,captchaId:ve(),captchaInfo:"",registerType:"email"},formLoading:!1,showRetrievePasswordDialog:!1,retrievePasswordForm:{type:"email",account:"",captcha:"",password:""},dialogWidth:36,userLoginCaptchaSwitch:!0,accountVerificationType:[],codeSendCountdown:0,submitRetrieveLoading:!1,sendCaptchaLoading:!1,to:z.query.to}),Q=S({email:[m({name:"required",title:a("user.login.email")}),m({name:"email",title:a("user.login.email")})],username:[m({name:"required",title:a("user.login.User name")}),{validator:(i,o,d)=>{if(e.form.tab=="register")return Ve(i,o,d);d()},trigger:"blur"}],password:[m({name:"required",title:a("user.login.password")}),m({name:"password"})],mobile:[m({name:"required",title:a("user.login.mobile")}),m({name:"mobile"})],captcha:[m({name:"required",title:a("user.login.Verification Code")})]}),X=S({account:[m({name:"required",title:a("user.login.Account name")})],captcha:[m({name:"required",title:a("user.login.Verification Code")})],password:[m({name:"required",title:a("user.login.password")}),m({name:"password"})]}),L=()=>{let i=document.documentElement.clientWidth,o=36;i<=790?o=92:i<=910?o=56:i<=1260&&(o=46),e.dialogWidth=o},T=()=>{var i;(i=h.value)==null||i.validate(o=>{o&&(e.form.tab=="login"&&e.userLoginCaptchaSwitch?x(e.form.captchaId,d=>I(d)):I())})},I=(i="")=>{e.formLoading=!0,e.form.captchaInfo=i,W("post",e.form).then(o=>{if(G.dataFill(o.data.userInfo),e.to)return location.href=e.to;H.push({path:o.data.routePath})}).finally(()=>{e.formLoading=!1})},U=()=>{y.value&&y.value.validate(i=>{i&&(e.submitRetrieveLoading=!0,he(e.retrievePasswordForm).then(o=>{e.submitRetrieveLoading=!1,o.code==1&&(e.showRetrievePasswordDialog=!1,F(),ye(y.value))}).catch(()=>{e.submitRetrieveLoading=!1}))})},Y=()=>{e.codeSendCountdown>0||h.value.validateField([e.form.registerType,"username","password"]).then(i=>{i&&x(e.form.captchaId,o=>Z(o))})},Z=i=>{e.sendCaptchaLoading=!0,(e.form.registerType=="email"?K:j)(e.form[e.form.registerType],"user_register",{captchaInfo:i,captchaId:e.form.captchaId}).then(d=>{d.code==1&&D(60)}).finally(()=>{e.sendCaptchaLoading=!1})},ee=()=>{e.codeSendCountdown>0||y.value.validateField("account").then(i=>{i&&x(e.form.captchaId,o=>oe(o))})},oe=i=>{e.sendCaptchaLoading=!0,(e.retrievePasswordForm.type=="email"?K:j)(e.retrievePasswordForm.account,"user_retrieve_pwd",{captchaInfo:i,captchaId:e.form.captchaId}).then(d=>{d.code==1&&D(60)}).finally(()=>{e.sendCaptchaLoading=!1})},q=(i=void 0,o)=>{e.form.tab=o,o=="register"&&(e.form.username=""),i&&i.clearValidate()},D=i=>{e.codeSendCountdown=i,k=window.setInterval(()=>{e.codeSendCountdown--,e.codeSendCountdown<=0&&F()},1e3)},F=()=>{e.codeSendCountdown=0,clearInterval(k)};return ue(async()=>{await Ce()||(L(),_e(window,"resize",L),W("get").then(i=>{e.userLoginCaptchaSwitch=i.data.userLoginCaptchaSwitch,e.accountVerificationType=i.data.accountVerificationType,e.retrievePasswordForm.type=i.data.accountVerificationType.length>0?i.data.accountVerificationType[0]:""}),z.query.type=="register"&&(e.form.tab="register"))}),ce(()=>{e.codeSendCountdown=0,F()}),(i,o)=>{const d=s("el-radio"),N=s("el-radio-group"),c=s("el-form-item"),g=s("Icon"),w=s("el-input"),V=s("el-col"),b=s("el-button"),R=s("el-row"),ae=s("el-checkbox"),$=s("el-form"),re=s("el-alert"),te=s("el-main"),le=s("el-container"),ie=s("el-dialog");return f(),C("div",Se,[r(le,{class:"is-vertical"},{default:t(()=>[r(me),r(te,{class:"frontend-footer-brother"},{default:t(()=>[r(R,{justify:"center"},{default:t(()=>[r(V,{span:16,xs:24},{default:t(()=>[l(J).state.open?(f(),C("div",xe,[M("div",ze,u(l(a)("user.login."+e.form.tab)+l(a)("user.login.reach")+l(O).siteName),1),r($,{ref_key:"formRef",ref:h,onKeyup:B(T,["enter"]),rules:Q,model:e.form},{default:t(()=>[e.form.tab=="register"?(f(),v(c,{key:0},{default:t(()=>[r(N,{size:"large",modelValue:e.form.registerType,"onUpdate:modelValue":o[0]||(o[0]=n=>e.form.registerType=n)},{default:t(()=>[r(d,{class:"register-verification-radio",value:"email",disabled:!e.accountVerificationType.includes("email"),border:""},{default:t(()=>[p(u(l(a)("user.login.Via email")+l(a)("user.login.register")),1)]),_:1},8,["disabled"]),r(d,{class:"register-verification-radio",value:"mobile",disabled:!e.accountVerificationType.includes("mobile"),border:""},{default:t(()=>[p(u(l(a)("user.login.Via mobile number")+l(a)("user.login.register")),1)]),_:1},8,["disabled"])]),_:1},8,["modelValue"])]),_:1})):_("",!0),r(c,{prop:"username"},{default:t(()=>[r(w,{modelValue:e.form.username,"onUpdate:modelValue":o[1]||(o[1]=n=>e.form.username=n),placeholder:e.form.tab=="register"?l(a)("Please input field",{field:l(a)("user.login.User name")}):l(a)("Please input field",{field:l(a)("user.login.account")}),clearable:!0,size:"large"},{prefix:t(()=>[r(g,{name:"fa fa-user",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1}),r(c,{prop:"password"},{default:t(()=>[r(w,{modelValue:e.form.password,"onUpdate:modelValue":o[2]||(o[2]=n=>e.form.password=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.password")}),type:"password","show-password":"",size:"large"},{prefix:t(()=>[r(g,{name:"fa fa-unlock-alt",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1}),e.form.tab=="register"&&e.form.registerType=="mobile"?(f(),v(c,{key:1,prop:"mobile"},{default:t(()=>[r(w,{modelValue:e.form.mobile,"onUpdate:modelValue":o[3]||(o[3]=n=>e.form.mobile=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.mobile")}),clearable:!0,size:"large"},{prefix:t(()=>[r(g,{name:"fa fa-tablet",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1})):_("",!0),e.form.tab=="register"&&e.form.registerType=="email"?(f(),v(c,{key:2,prop:"email"},{default:t(()=>[r(w,{modelValue:e.form.email,"onUpdate:modelValue":o[4]||(o[4]=n=>e.form.email=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.email")}),clearable:!0,size:"large"},{prefix:t(()=>[r(g,{name:"fa fa-envelope",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1})):_("",!0),e.form.tab=="register"?(f(),v(c,{key:3,prop:"captcha"},{default:t(()=>[r(R,{class:"w100"},{default:t(()=>[r(V,{span:16},{default:t(()=>[r(w,{size:"large",modelValue:e.form.captcha,"onUpdate:modelValue":o[5]||(o[5]=n=>e.form.captcha=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.Verification Code")}),autocomplete:"off"},{prefix:t(()=>[r(g,{name:"fa fa-ellipsis-h",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1}),r(V,{class:"captcha-box",span:8},{default:t(()=>[r(b,{size:"large",onClick:Y,loading:e.sendCaptchaLoading,disabled:!(e.codeSendCountdown<=0),type:"primary"},{default:t(()=>[p(u(e.codeSendCountdown<=0?l(a)("user.login.send"):e.codeSendCountdown+l(a)("user.login.seconds")),1)]),_:1},8,["loading","disabled"])]),_:1})]),_:1})]),_:1})):_("",!0),e.form.tab!="register"?(f(),C("div",Le,[r(ae,{modelValue:e.form.keep,"onUpdate:modelValue":o[6]||(o[6]=n=>e.form.keep=n),label:l(a)("user.login.Remember me"),size:"default"},null,8,["modelValue","label"]),e.accountVerificationType.length>0?(f(),C("div",{key:0,onClick:o[7]||(o[7]=n=>e.showRetrievePasswordDialog=!0),class:"forgot-password"},u(l(a)("user.login.Forgot your password?")),1)):_("",!0)])):_("",!0),r(c,{class:"form-buttons"},{default:t(()=>[r(b,{class:"login-btn",onClick:T,loading:e.formLoading,round:"",type:"primary",size:"large"},{default:t(()=>[p(u(l(a)("user.login."+e.form.tab)),1)]),_:1},8,["loading"]),e.form.tab=="register"?(f(),v(b,{key:0,onClick:o[8]||(o[8]=n=>q(h.value,"login")),round:"",plain:"",type:"info",size:"large"},{default:t(()=>[p(u(l(a)("user.login.Back to login")),1)]),_:1})):(f(),v(b,{key:1,onClick:o[9]||(o[9]=n=>q(h.value,"register")),round:"",plain:"",type:"info",size:"large"},{default:t(()=>[p(u(l(a)("user.login.No account yet? Click Register")),1)]),_:1}))]),_:1}),r(Re)]),_:1},8,["rules","model"])])):(f(),v(re,{key:1,center:!0,title:i.$t("Member center disabled"),type:"error"},null,8,["title"]))]),_:1})]),_:1})]),_:1}),r(fe)]),_:1}),r(ie,{"close-on-click-modal":!1,"close-on-press-escape":!1,modelValue:e.showRetrievePasswordDialog,"onUpdate:modelValue":o[17]||(o[17]=n=>e.showRetrievePasswordDialog=n),title:l(a)("user.login.Retrieve password"),width:e.dialogWidth+"%",draggable:!0},{default:t(()=>[M("div",Te,[r($,{ref_key:"retrieveFormRef",ref:y,onKeyup:o[16]||(o[16]=B(n=>U(),["enter"])),rules:X,model:e.retrievePasswordForm,"label-width":100},{default:t(()=>[r(c,{label:l(a)("user.login.Retrieval method")},{default:t(()=>[r(N,{modelValue:e.retrievePasswordForm.type,"onUpdate:modelValue":o[10]||(o[10]=n=>e.retrievePasswordForm.type=n)},{default:t(()=>[r(d,{value:"email",disabled:!e.accountVerificationType.includes("email"),border:""},{default:t(()=>[p(u(l(a)("user.login.Via email")),1)]),_:1},8,["disabled"]),r(d,{value:"mobile",disabled:!e.accountVerificationType.includes("mobile"),border:""},{default:t(()=>[p(u(l(a)("user.login.Via mobile number")),1)]),_:1},8,["disabled"])]),_:1},8,["modelValue"])]),_:1},8,["label"]),r(c,{prop:"account",label:e.retrievePasswordForm.type=="email"?l(a)("user.login.email"):l(a)("user.login.mobile")},{default:t(()=>[r(w,{modelValue:e.retrievePasswordForm.account,"onUpdate:modelValue":o[11]||(o[11]=n=>e.retrievePasswordForm.account=n),placeholder:l(a)("Please input field",{field:e.retrievePasswordForm.type=="email"?l(a)("user.login.email"):l(a)("user.login.mobile")}),clearable:!0},{prefix:t(()=>[r(g,{name:"fa fa-user",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1},8,["label"]),r(c,{prop:"captcha",label:l(a)("user.login.Verification Code")},{default:t(()=>[r(R,{class:"w100"},{default:t(()=>[r(V,{span:16},{default:t(()=>[r(w,{modelValue:e.retrievePasswordForm.captcha,"onUpdate:modelValue":o[12]||(o[12]=n=>e.retrievePasswordForm.captcha=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.Verification Code")}),autocomplete:"off"},{prefix:t(()=>[r(g,{name:"fa fa-ellipsis-h",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1}),r(V,{class:"captcha-box",span:8},{default:t(()=>[r(b,{onClick:ee,loading:e.sendCaptchaLoading,disabled:!(e.codeSendCountdown<=0),type:"primary"},{default:t(()=>[p(u(e.codeSendCountdown<=0?l(a)("user.login.send"):e.codeSendCountdown+l(a)("user.login.seconds")),1)]),_:1},8,["loading","disabled"])]),_:1})]),_:1})]),_:1},8,["label"]),r(c,{prop:"password",label:l(a)("user.login.New password")},{default:t(()=>[r(w,{modelValue:e.retrievePasswordForm.password,"onUpdate:modelValue":o[13]||(o[13]=n=>e.retrievePasswordForm.password=n),placeholder:l(a)("Please input field",{field:l(a)("user.login.New password")}),"show-password":""},{prefix:t(()=>[r(g,{name:"fa fa-unlock-alt",size:"16",color:"var(--el-input-icon-color)"})]),_:1},8,["modelValue","placeholder"])]),_:1},8,["label"]),r(c,null,{default:t(()=>[r(b,{onClick:o[14]||(o[14]=n=>e.showRetrievePasswordDialog=!1)},{default:t(()=>[p(u(l(a)("Cancel")),1)]),_:1}),r(b,{loading:e.submitRetrieveLoading,onClick:o[15]||(o[15]=n=>U()),type:"primary"},{default:t(()=>[p(u(l(a)("user.login.second")),1)]),_:1},8,["loading"])]),_:1})]),_:1},8,["rules","model"])])]),_:1},8,["modelValue","title","width"])])}}}),We=A(Ie,[["__scopeId","data-v-a35400b5"]]);export{We as default};
