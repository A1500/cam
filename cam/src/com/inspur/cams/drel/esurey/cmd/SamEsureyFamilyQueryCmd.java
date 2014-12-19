package com.inspur.cams.drel.esurey.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilyDomain;


public class SamEsureyFamilyQueryCmd extends BaseQueryCommand{
	private ISamEsureyFamilyDomain service = ScaComponentFactory.getService(
			ISamEsureyFamilyDomain.class, "SamEsureyFamilyDomain/SamEsureyFamilyDomain");

	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		DataSet familyDS=service.query(pset);
		
		ArrayList<Record> list=new ArrayList<Record>();
		familyDS.addField("domicileName");
		familyDS.addField("apanageName");
		for(int i=0;i<familyDS.getCount();i++){
			Record familyRecord=familyDS.getRecord(i);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			//获取domicileName
			if(familyRecord.get("regAddress")!=null){
	
			String domicileCode=familyRecord.get("regAddress").toString();
	
				pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDS=dao.query(pset);
				Record domicileCodeRecord = domicileCodeDS.getRecord(0);
				String domicileName = domicileCodeRecord.get("name").toString();	
				familyRecord.set("domicileName", domicileName);
			}
			
			
			//获取apanageName
			
			if(familyRecord.get("familyAddress")!=null){
				String apanageCode = familyRecord.get("familyAddress").toString();
				pset.clear();
				pset.setParameter("ID", apanageCode);
				DataSet apanageCodeDataSet = dao.query(pset);
				Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
				String apanageName = apanageCodeRecord.get("name").toString();
				familyRecord.set("apanageName", apanageName);
			}
	
			list.add(familyRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(familyDS.getTotalCount());
		return ds;
	}
	//根据家庭Id数组查询家庭
	public DataSet queryByFamilyIds(){
		ParameterSet pset=getParameterSet();
		return service.queryByFamilyIds(pset);
	}


	public DataSet familySum(){
		ParameterSet pset = getParameterSet();
		String familyId=(String)pset.getParameter("familyId");
		DataSet ds=service.familySum(familyId);
		return ds;
	}
	/**
	 * 查询统计
	 */
	public DataSet queryStatistics(){
		ParameterSet pset=getParameterSet();
		return service.queryStatistics(pset);
	}
	/**
	 * 收入或财产统计
	 */
	public DataSet queryIncomeWorth(){
		ParameterSet pset=getParameterSet();
		return service.queryIncomeWorth(pset);
	}
	public DataSet queryCredit() {
		ParameterSet pset = getParameterSet();
		return service.queryCredit(pset);
	}
}