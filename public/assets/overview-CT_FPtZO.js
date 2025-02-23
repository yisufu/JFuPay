import{x as B,b as z,af as G,i as N,f as A,ag as R,X as U,_ as V}from"./index-B0iOz79E.js";import{e as D,a0 as E,p as F,a as L,az as S,z as j,aj as M,m as d,W as O,o as k,h as T,l as t,O as a,k as r,V as l,Z as q,N as P,v as o,U as i,n as W}from"./vue-DkQzphiS.js";import{i as X}from"./echarts-CUeaqhHS.js";const Z={class:"user-views"},H={class:"card-header"},J={class:"overview-userinfo"},K={class:"user-avatar"},Q=["src"],Y={class:"user-avatar-icons"},x={class:"user-data"},ee={class:"welcome-words"},te=D({__name:"overview",setup(ae){const{t:p}=B.useI18n(),v=E(),c=z(),f=F(),n=L({days:[],score:[],money:[],charts:[]}),b=()=>{const e=X(f.value),s={grid:{top:10,right:0,bottom:20,left:50},xAxis:{data:n.days},yAxis:{},legend:{data:[p("Integral"),p("Balance")]},series:[{name:p("Integral"),data:n.score,type:"line",smooth:!0,show:!1,color:"#f56c6c",emphasis:{label:{show:!0}},areaStyle:{}},{name:p("Balance"),data:n.money,type:"line",smooth:!0,show:!1,color:"#409eff",emphasis:{label:{show:!0}},areaStyle:{opacity:.4}}]};e.setOption(s),n.charts.push(e)},_=()=>{W(()=>{for(const e in n.charts)n.charts[e].resize()})};return S(()=>{_()}),j(()=>{G().then(e=>{n.days=e.data.days,n.score=e.data.score,n.money=e.data.money,b()}),N(window,"resize",_)}),M(()=>{for(const e in n.charts)n.charts[e].dispose()}),(e,s)=>{const C=d("el-button"),h=d("Icon"),w=d("el-tooltip"),u=d("el-col"),y=d("el-link"),g=d("el-row"),$=d("el-card"),I=O("blur");return k(),T("div",Z,[t($,{class:"user-views-card",shadow:"hover"},{header:a(()=>[r("div",H,[r("span",null,l(e.$t("user.account.overview.Account information")),1),q((k(),P(C,{onClick:s[0]||(s[0]=m=>o(v).push({name:"account/profile"})),type:"info",plain:""},{default:a(()=>[i(l(e.$t("user.account.overview.personal data")),1)]),_:1})),[[I]])])]),default:a(()=>[r("div",J,[r("div",K,[r("img",{src:o(A)(o(c).avatar),alt:""},null,8,Q),r("div",Y,[r("div",{onClick:s[1]||(s[1]=m=>o(v).push({name:"account/profile"})),class:"avatar-icon-item"},[t(w,{effect:"light",placement:"right",content:(o(c).mobile?e.$t("user.account.overview.Filled in"):e.$t("user.account.overview.Not filled in"))+e.$t("user.account.overview.mobile")},{default:a(()=>[t(h,{name:"fa fa-tablet",size:"16",color:o(c).mobile?"var(--el-color-primary)":"var(--el-text-color-secondary)"},null,8,["color"])]),_:1},8,["content"])]),r("div",{onClick:s[2]||(s[2]=m=>o(v).push({name:"account/profile"})),class:"avatar-icon-item"},[t(w,{effect:"light",placement:"right",content:(o(c).email?e.$t("user.account.overview.Filled in"):e.$t("user.account.overview.Not filled in"))+e.$t("user.account.overview.email")},{default:a(()=>[t(h,{name:"fa fa-envelope-square",size:"14",color:o(c).email?"var(--el-color-primary)":"var(--el-text-color-secondary)"},null,8,["color"])]),_:1},8,["content"])])])]),r("div",x,[r("div",ee,l(o(c).nickname+e.$t("utils.comma")+o(R)()),1),t(g,{class:"data-item"},{default:a(()=>[t(u,{span:4},{default:a(()=>[i(l(e.$t("Integral")),1)]),_:1}),t(u,{span:8},{default:a(()=>[t(y,{onClick:s[3]||(s[3]=m=>o(v).push({name:"account/integral"})),type:"primary"},{default:a(()=>[i(l(o(c).score),1)]),_:1})]),_:1}),t(u,{span:4},{default:a(()=>[i(l(e.$t("Balance")),1)]),_:1}),t(u,{span:8},{default:a(()=>[t(y,{onClick:s[4]||(s[4]=m=>o(v).push({name:"account/balance"})),type:"primary"},{default:a(()=>[i(l(o(c).money),1)]),_:1})]),_:1})]),_:1}),t(g,{class:"data-item"},{default:a(()=>[t(u,{class:"lastlogin title",span:4},{default:a(()=>[i(l(e.$t("user.account.overview.Last login")),1)]),_:1}),t(u,{class:"lastlogin value",span:8},{default:a(()=>[i(l(o(U)(o(c).last_login_time)),1)]),_:1}),t(u,{class:"lastip",span:4},{default:a(()=>[i(l(e.$t("user.account.overview.Last login IP")),1)]),_:1}),t(u,{class:"lastip",span:8},{default:a(()=>[i(l(o(c).last_login_ip),1)]),_:1})]),_:1})])])]),_:1}),t($,{class:"user-views-card",shadow:"hover",header:e.$t("user.account.overview.Growth statistics")},{default:a(()=>[r("div",{class:"account-growth",ref_key:"accountGrowthChartRef",ref:f},null,512)]),_:1},8,["header"])])}}}),re=V(te,[["__scopeId","data-v-ceccd0d9"]]);export{re as default};
