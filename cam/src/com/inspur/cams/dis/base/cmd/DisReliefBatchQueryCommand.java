package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDomain;
/**
 * @title:DisReliefInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefBatchQueryCommand extends BaseQueryCommand{
	private IDisReliefBatchDomain service = ScaComponentFactory.getService(IDisReliefBatchDomain.class,
													"disReliefBatchDomain/disReliefBatchDomain");
	
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds= service.query(pset);
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		for (int i=0;i<ds.getCount();i++) {
			StringBuffer areaName=new StringBuffer();
			String areaCode = (String)ds.getRecord(i).get("areaCode");
			String[] areaCodes=areaCode.split(",");
			for (String area : areaCodes) {
				pset.clear();
				pset.setParameter("ID", area);
				DataSet CodeDataSet = dao.query(pset);
				if(CodeDataSet.getCount()>0){
					Record apanageCodeRecord = CodeDataSet.getRecord(0);
					areaName.append((String)apanageCodeRecord.get("fullName")+",");
				}
			}
			ds.getRecord(i).set("areaName", areaName.toString());
		}
		
		return ds;
	}
	
	public DataSet queryBatchStatis() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryBatchStatis(pset);
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		for (int i=0;i<ds.getCount();i++) {
			StringBuffer areaName=new StringBuffer();
			String areaCode = (String)ds.getRecord(i).get("AREA_CODE");
			if(!PubUtils.isEmpty(areaCode)) {
				String[] areaCodes=areaCode.split(",");
				for (String area : areaCodes) {
					pset.clear();
					pset.setParameter("ID", area);
					DataSet CodeDataSet = dao.query(pset);
					if(CodeDataSet.getCount()>0){
						Record apanageCodeRecord = CodeDataSet.getRecord(0);
						areaName.append((String)apanageCodeRecord.get("fullName")+",");
					}
				}
				ds.getRecord(i).set("areaName", areaName.toString());
			} else {
				ds.getRecord(i).set("areaName", "");
			}
		}
		return ds;
	}
	
	public DataSet queryBatchForRoster(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryBatchForRoster(pset);
		return ds;
	}
}
