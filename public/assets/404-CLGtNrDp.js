import{e as m,a0 as _,p as v,z as f,C as h,m as g,o as k,h as C,k as e,V as o,U as n,l as c,O as d}from"./vue-DkQzphiS.js";import{_ as $}from"./index-B0iOz79E.js";const B="/assets/qr-CamScR9_.png",b={class:"page"},w={class:"container"},M={class:"tip"},R={class:"complete"},V={class:"percentage"},N={class:"details"},T={class:"stopcode"},q={class:"stopcode-text"},y={class:"stopcode-text"},I=m({__name:"404",setup(S){const p=_(),a=v(0);var r=null;function u(){a.value+=Math.floor(Math.random()*50),a.value>=100?(a.value=100,p.back()):i()}function i(){r=setTimeout(u,Math.random()*500+500)}return f(()=>{i()}),h(()=>{clearTimeout(r)}),(t,s)=>{const l=g("router-link");return k(),C("div",b,[e("div",w,[s[3]||(s[3]=e("div",{class:"font-h1"},":(",-1)),e("div",M,o(t.$t("404.problems tip")),1),e("div",R,[n(o(t.$t("Complete"))+" ",1),e("span",V,o(a.value),1),s[1]||(s[1]=n("% "))]),e("div",N,[s[2]||(s[2]=e("div",{class:"qr-image"},[e("img",{src:B,alt:"QR Code"})],-1)),e("div",T,[e("div",q,o(t.$t("404.We will automatically return to the previous page when we are finished")),1),e("div",y,[c(l,{class:"stopcode-a",to:""},{default:d(()=>[e("span",{onClick:s[0]||(s[0]=U=>t.$router.back())},o(t.$t("404.Back to previous page")),1)]),_:1}),c(l,{class:"stopcode-a",to:"/"},{default:d(()=>[n(o(t.$t("404.Return to home page")),1)]),_:1})])])])])])}}}),D=$(I,[["__scopeId","data-v-1e5abc9c"]]);export{D as default};
