package com.inspur.cams.bpt.manage.cmd;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.loushang.next.dao.DaoFactory;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.data.BptDecisionLetter;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptDecisionLetterDomain;
import com.inspur.cams.comm.diccity.dao.IDicCityDao;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;

public class BptDecisionLetterQueryCommand extends BaseQueryCommand {
	
	IBptDecisionLetterDomain decisionLetterService = ScaComponentFactory.getService(IBptDecisionLetterDomain.class,
	"bptDecisionLetterDomain/bptDecisionLetterDomain");
	
	IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain= ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
	"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
	
	public DataSet queryDecisionLetter() {
		ParameterSet pset = this.getParameterSet();
		List<String> list = new ArrayList<String>();
		String organId = (String)pset.get("organId");
		String applyId = (String)pset.get("APPLY_ID");
		String peopleId = (String)pset.get("PEOPLE_ID");
		pset.remove("organId");
		DataSet decisionDataset = decisionLetterService.queryDecisionLetter(pset);
		pset.remove("APPLY_ID");
		DataSet peopleDataset = bptBaseinfoPeopleDomain.queryBaseinfoPeople(pset);
		String name =new String();
		String domicile="";
		if((organId.substring(0, 2)+"0000000000").equals(organId.substring(0, 4)+"00000000")){
			list.add(organId.substring(0, 2)+"0000000000");
			domicile= findOrgan(list)+"民政厅";
		}else if((organId.substring(0, 4)+"0000000000").equals(organId.substring(0, 6)+"00000000")){
			list.add(organId.substring(0, 4)+"00000000");
			domicile= findOrgan(list)+"民政局";
		}else{
			list.add(organId.substring(0, 6)+"000000");
			domicile= findOrgan(list)+"民政局";
		}
		
		if(peopleDataset.getCount()>0){
			Record pr = peopleDataset.getRecord(0);
			name = (String)pr.get("name");
			
		}
		if(decisionDataset.getCount()>0){
			decisionDataset.getRecord(0).set("domicile", domicile);
			decisionDataset.getRecord(0).set("name", name);
			return decisionDataset;
		}else{
			
			Record dr= new Record();
			dr.set("domicile", domicile);
			dr.set("name", name);
			DataSet ds= new DataSet(dr);
			return ds;
		}
		
	}
	private String findOrgan (List<String> list) {
		StringBuffer organ = new StringBuffer();
		ParameterSet pset = new ParameterSet();
		IDicCityDao dao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		
		for (int i = 0; i < list.size(); i++) {
			String id= (String)list.get(i);
			pset.setParameter("id", id);
			DataSet dicBeanDataset = dao.query(pset);
			if(dicBeanDataset.getCount()>0){
				organ.append((String)dicBeanDataset.getRecord(0).get("name"));
			}
		}
		return organ.toString();
	}
}
