package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalSpPerDomain;
/***
 * 一站结算_优抚救助比例查询
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalSpPerQueryCmd  extends BaseQueryCommand{
	private ISamMedicalSpPerDomain samMedicalSpPerDomain=ScaComponentFactory.getService(ISamMedicalSpPerDomain.class, "samMedicalSpPerDomain/samMedicalSpPerDomain");
	EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet samMBalance = samMedicalSpPerDomain.query(pset);
		ArrayList<Record> list=new ArrayList<Record>();
		samMBalance.addField("domicileName");
		for(int i=0;i<samMBalance.getCount();i++){	
			Record familyRecord=samMBalance.getRecord(i);
			//获取domicileName
			if(familyRecord.get("domicileCode")!=null){
	
			String domicileCode=familyRecord.get("domicileCode").toString();
			pset.clear();
				pset.setParameter("ID", domicileCode);
				DataSet domicileCodeDS=dao.query(pset);
				if(domicileCodeDS.getCount()!=0){
					Record domicileCodeRecord = domicileCodeDS.getRecord(0);
					String domicileName = domicileCodeRecord.get("name").toString();	
					familyRecord.set("domicileName", domicileName);
				}else{
					familyRecord.set("domicileName", "没找到");
				}
				
			}
			list.add(familyRecord);
		}
		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(samMBalance.getTotalCount());
		return ds;
	}
}
