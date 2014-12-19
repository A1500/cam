package com.inspur.cams.bpt.manage.cmd;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.data.BptDisabilityOpen;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptDisabilityOpenDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.comm.diccity.dao.IDicCityDao;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;

public class BptDisabilityOpenQueryCommand extends BaseQueryCommand{
	
	IBptDisabilityOpenDomain openService = ScaComponentFactory.getService(IBptDisabilityOpenDomain.class,
	"bptDisbilityOpenDomain/bptDisbilityOpenDomain");
	
	IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain= ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
	"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
	
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
	"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	
	/**
	 * 查询公示书信息
	 * @return
	 */
	public DataSet queryDisabilityOpen(){
		DataSet ds = new DataSet();
		Record precord = new Record();
		Record orecord = new Record();
		ParameterSet pset= this.getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = (String)pset.getParameter("applyId");
		String organId = (String)pset.getParameter("organId");
		pset.clear();
		pset.setParameter("people_id", peopleId);
		if(peopleId !=null&&!"".equals(peopleId)){
			DataSet pd = bptBaseinfoPeopleDomain.queryBaseinfoPeople(pset);
			if(pd.getCount()>0){
				precord = pd.getRecord(0);
			}
		}
		pset.clear();
		pset.setParameter("apply_id", applyId);
		if(applyId !=null&&!"".equals(applyId)){
			DataSet od = openService.queryDisabilityOpen(pset);
			List<String> list = new ArrayList<String>();
			if(od.getCount()>0){
				orecord = od.getRecord(0);
				precord.set("disabilityDate", orecord.get("disabilityDate"));
				precord.set("disabilityAdd", orecord.get("disabilityAdd"));
				precord.set("disabilityReason", orecord.get("disabilityReason"));
				precord.set("disabilityCondition", orecord.get("disabilityCondition"));
				precord.set("openstartDate", orecord.get("openstartDate"));
				precord.set("openendDate", orecord.get("openendDate"));
				precord.set("openDate", orecord.get("openDate"));
				//list.add(organId.substring(0, 4)+"00000000");
				String domicile="";
				//list.add(organId.substring(0, 6)+"000000");
				if((organId.substring(0, 2)+"0000000000").equals(organId.substring(0, 4)+"00000000")){
					list.add(organId.substring(0, 4)+"00000000");
					domicile= findOrgan(list)+"民政厅";
				}else{
					//list.add(organId.substring(0, 4)+"00000000");
					list.add(organId.substring(0, 6)+"000000");
					domicile= findOrgan(list)+"民政局";
				}
				//String domicile= findOrgan(list)+"民政局";
				precord.set("domicile", domicile);
				precord.set("organId", organId);
				precord.set("applyId", orecord.get("applyId"));
			}else{
				pset.clear();
				pset.setParameter("people_id", peopleId);
				DataSet da = disabilityService.queryBptPeopleDisability(pset);
				if(da.getCount()>0){
					Record r= da.getRecord(0);
					Calendar ca = Calendar.getInstance();
					ca.add(Calendar.DAY_OF_MONTH, 7);
					Date d=ca.getTime();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					String date= format.format(new Date());
					String date2= format.format(d);
					precord.set("disabilityDate", r.get("disabilityDate"));
					precord.set("disabilityAdd", r.get("disabilityAdd"));
					precord.set("disabilityReason", r.get("disabilityReason"));
					precord.set("disabilityCondition", "受伤部位:"+r.get("disabilityBody"));
					precord.set("openstartDate", date);
					precord.set("openendDate", date2);
					precord.set("openDate", date);
					//list.add(organId.substring(0, 4)+"00000000");
					/*list.add(organId.substring(0, 6)+"000000");
					String domicile= findOrgan(list)+"民政局";*/
					String domicile="";
					//list.add(organId.substring(0, 6)+"000000");
					if((organId.substring(0, 4)+"00000000").equals(organId.substring(0, 6)+"000000")){
						list.add(organId.substring(0, 4)+"00000000");
						domicile= findOrgan(list)+"民政厅";
					}else{
						//list.add(organId.substring(0, 4)+"00000000");
						list.add(organId.substring(0, 6)+"000000");
						domicile= findOrgan(list)+"民政局";
					}
					precord.set("domicile", domicile);
					precord.set("organId", organId);
					precord.set("aplyId", applyId);
					
					BptDisabilityOpen open = new BptDisabilityOpen();
					open.setApplyId(applyId);
					open.setPeopleId(peopleId);
					open.setDisabilityAdd((String)r.get("disabilityAdd"));
					open.setDisabilityCondition("受伤部位:"+r.get("disabilityBody"));
					open.setDisabilityDate((String)r.get("disabilityDate"));
					open.setDisabilityReason((String)r.get("disabilityReason"));
					open.setOpenDate(date);
					open.setOpenstartDate(date);
					open.setOpenendDate(date2);
					open.setOrganId(organId);
					open.setDisabilityCaseCode((String)r.get("disabilityCaseCode"));
					open.setDisabilityLevelCode((String)r.get("disabilityLevelCode"));
					openService.saveOpen(open);
				}
			}
		}
		
		
		ds.add(precord);
		return ds;
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
				organ.append((String)dicBeanDataset.getRecord(0).get("fullName"));
			}
		}
		return organ.toString();
	}
	
	
}
