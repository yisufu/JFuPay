import{i as d,B as m}from"./index-CJwZD0Ka.js";import{e as f,ay as b,f as y,l,m as u}from"./vue-DkQzphiS.js";import{_ as v}from"./index-B0iOz79E.js";const V=f({name:"formItem",props:{type:{type:String,required:!0,validator:e=>d.includes(e)},modelValue:{required:!0},inputAttr:{type:Object,default:()=>{}},blockHelp:{type:String,default:""},tip:[String,Object],attr:{type:Object,default:()=>{}},data:{type:Object,default:()=>{}},placeholder:{type:String,default:""},...b},emits:["update:modelValue"],setup(e,{emit:p,slots:i}){const s=["type","modelValue","inputAttr","attr","data","placeholder"],a=y(()=>{const t=e.attr||{};for(const o in e){const n=e[o];!s.includes(o)&&(n||n===!1)&&(t[o]=n)}return t}),c=t=>{p("update:modelValue",t)},r={};if(r.default=()=>{let t=l(m,{type:e.type,attr:{placeholder:e.placeholder,...e.inputAttr,...e.data},modelValue:e.modelValue,"onUpdate:modelValue":c},i);return a.value.blockHelp?[t,l("div",{class:"block-help"},a.value.blockHelp)]:t},a.value.tip){const t=()=>{const o=typeof a.value.tip=="string"?{content:a.value.tip,placement:"top"}:a.value.tip;return l(u("el-tooltip"),o,{default:()=>[l("i",{class:"fa fal fa-question-circle"})]})};r.label=()=>l("span",{class:"ba-form-item-label"},[l("span",null,a.value.label),l("span",{class:"ba-form-item-label-tip"},[t()])])}return()=>l(u("el-form-item"),{class:"ba-input-item-"+e.type,...a.value},r)}}),h=v(V,[["__scopeId","data-v-54bbc833"]]);export{h as F};
