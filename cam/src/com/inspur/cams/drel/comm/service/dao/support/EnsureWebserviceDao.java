package com.inspur.cams.drel.comm.service.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.comm.service.dao.IEnsureWebserviceDao;

public  class EnsureWebserviceDao extends EntityDao<EnsureWebserviceDao> implements IEnsureWebserviceDao{

	public String queryExport(ParameterSet pset) {
		 String applyId=(String)pset.getParameter("applyIds");
		 String[] applyIds = (String[]) applyId.split(","); 
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select *  ");
		 sql.append(" left join BASEINFO_PEOPLE p on p.family_id = t.family_id  where");
		 
			 for(int i=0;i<applyIds.length;i++){
				 if(i==0){
					 sql.append(" t.apply_id = ? ");
					 typeList.add(Types.VARCHAR);
					argsList.add(applyIds[i]);
				 }else{
					 sql.append(" or t.apply_id = ?  ");
					 typeList.add(Types.VARCHAR);
					argsList.add(applyIds[i]);
				 }
				
				
			}
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds =  this.executeDataset(sql.toString(), types, args, true);
		 
		 
		 StringBuffer xml = new StringBuffer();
		 xml.append("<Government><br><Header>");
		 //头信息
		 xml.append("<D204I000001>00201</D204I000001><D204I000002>110108</D204I000002><D204I000003>110108</D204I000003><D204I000004>110108</D204I000004><D204I000005>110108</D204I000005><D204I000006>110108</D204I000006>");
		 xml.append("</Header><Data>");
		 
		 for(int i=0;i<ds.getCount();i++){
			 //姓名
			 xml.append("<Record><D204A000003>"); xml.append(ds.getRecord(i).get("FAMILY_NAME")); xml.append("</D204A000003>");
			 //证件类型
			 xml.append("<D204A000004>"); xml.append(ds.getRecord(i).get("ID_CARD_TYPE")); xml.append("</D204A000004>");
			 //有效身份证件号码
			 xml.append("<D204A000005>"); xml.append(ds.getRecord(i).get("ID_CARD")); xml.append("</D204A000005>");
			 //出生年月
			 xml.append("<D204A010003>"); xml.append(ds.getRecord(i).get("BIRTHDAY")); xml.append("</D204A010003>");
			 //户籍类型
			 xml.append("<D204A010011>"); xml.append(ds.getRecord(i).get("DOMICILE_TYPE")); xml.append("</D204A010011>");
			 //救助类别
			 xml.append("<D204Z520001>"); xml.append(ds.getRecord(i).get("ASSISTANCE_TYPE")); xml.append("</D204Z520001>");
			//救助证号
			 xml.append("<D204Z520002>"); xml.append(ds.getRecord(i).get("CARD_NO")); xml.append("</D204Z520002>");
			 //月救助金额
			 xml.append("<D204Z520003>"); xml.append(ds.getRecord(i).get("ASSISTANCE_MONEY")); xml.append("</D204Z520003>");
			 //救助开始年月
			 xml.append("<D204Z520004>"); xml.append(ds.getRecord(i).get("BEGIN_DATE")); xml.append("</D204Z520004>");
			 //救助截止年月
			 xml.append("<D204Z520005>"); xml.append(ds.getRecord(i).get("END_DATE")); xml.append("</D204Z520005></Record>");
		 
		 }
		 
		 xml.append("</Data></Government>");
		 
		 return xml.toString();
		 
	}

	@Override
	protected Class getEntityClass() {
		// TODO 自动生成的方法存根
		return null;
	}
	
}