import{b as _,T as w,a as T}from"./index-CJwZD0Ka.js";import{x,a3 as k,a5 as C}from"./index-B0iOz79E.js";import{s as B,c as v,j as V}from"./crud-ByfC8q0v.js";import{e as D,a as I,p as N,at as R,z as q,B as E,m as i,o as S,h as A,l as r,O as s,v as l,U,V as z,n as F}from"./vue-DkQzphiS.js";const L=D({__name:"log",props:{modelValue:{type:Boolean,default:!1}},emits:["update:modelValue"],setup(p,{emit:m}){const b=p,n=m,c=I({ready:!1}),{t:e}=x.useI18n(),d=N(),f=[{render:"confirmButton",name:"copy",title:"crud.crud.copy",text:"",type:"primary",icon:"fa fa-copy",class:"table-row-copy",popconfirm:{confirmButtonText:e("Confirm"),cancelButtonText:e("Cancel"),confirmButtonType:"primary",title:e("crud.crud.Start CRUD design with this record?"),width:"220px"},disabledTip:!1,click:t=>{B.startData.logId=t[a.table.pk],v("log"),n("update:modelValue",!1)}},{render:"confirmButton",name:"del",title:"Delete",text:"",type:"danger",icon:"fa fa-trash",class:"table-row-delete",popconfirm:{confirmButtonText:e("crud.crud.Delete Code"),cancelButtonText:e("Cancel"),confirmButtonType:"danger",title:e("crud.crud.Are you sure to delete the generated CRUD code?"),width:"248px"},disabledTip:!1,click:t=>{V(t[a.table.pk]).then(()=>{a.onTableHeaderAction("refresh",{})})},display:t=>t.status!="delete"&&k("delete")}],a=new _(new C("/admin/crud.Log/"),{pk:"id",column:[{type:"selection",align:"center",operator:!1},{label:e("crud.log.id"),prop:"id",align:"center",width:70,operator:"=",operatorPlaceholder:e("Id"),sortable:"custom"},{label:e("crud.log.table_name"),operatorPlaceholder:e("Fuzzy query"),operator:"LIKE",render:"slot",slotName:"tableName"},{label:e("crud.log.status"),prop:"status",align:"center",render:"tag",sortable:!1,replaceValue:{delete:e("crud.log.status delete"),success:e("crud.log.status success"),error:e("crud.log.status error"),start:e("crud.log.status start")},custom:{delete:"danger",success:"success",error:"warning",start:""}},{label:e("crud.log.create_time"),prop:"create_time",align:"center",render:"datetime",operator:"RANGE",sortable:"custom",width:160,timeFormat:"yyyy-mm-dd hh:MM:ss"},{label:e("Operate"),align:"center",width:100,render:"buttons",buttons:f,operator:!1}],dblClickNotEditColumn:[void 0]},{defaultItems:{status:"start"}});R("baTable",a);const g=()=>{var t;(t=a.getIndex())==null||t.then(()=>{c.ready=!0})};return q(()=>{a.table.ref=d.value,a.mount()}),E(()=>b.modelValue,t=>{t&&!c.ready&&F(()=>{g()})}),(t,u)=>{const h=i("el-table-column"),y=i("el-dialog");return S(),A("div",null,[r(y,{onClose:u[0]||(u[0]=o=>n("update:modelValue",!1)),width:"60%","model-value":t.modelValue,class:"ba-crud-log-dialog",title:l(e)("crud.crud.CRUD record"),"append-to-body":!0,"destroy-on-close":!0},{default:s(()=>[r(w,{buttons:["refresh","quickSearch","columnDisplay"],"quick-search-placeholder":l(e)("Quick search placeholder",{fields:l(e)("crud.log.quick Search Fields")})},null,8,["quick-search-placeholder"]),r(T,{ref_key:"tableRef",ref:d},{tableName:s(()=>[r(h,{"show-overflow-tooltip":!0,prop:"table_name",align:"center",label:l(e)("crud.log.table_name")},{default:s(o=>[U(z((o.row.table.databaseConnection?o.row.table.databaseConnection+".":"")+o.row.table.name),1)]),_:1},8,["label"])]),_:1},512)]),_:1},8,["model-value","title"])])}}});export{L as _};
