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
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.data.BptDisabilityOpen;
import com.inspur.cams.bpt.base.data.BptOpenLetter;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptDisabilityOpenDomain;
import com.inspur.cams.bpt.base.domain.IBptOpenLetterDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.comm.diccity.dao.IDicCityDao;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;

public class BptOpenLetterQueryCommand extends BaseQueryCommand{
	
	IBptOpenLetterDomain openService = ScaComponentFactory.getService(IBptOpenLetterDomain.class,
	"bptOpenLetterDomain/bptOpenLetterDomain");
	
	IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain= ScaComponentFactory.getService(IBptBaseinfoPeopleDomain.class,
	"bptBaseinfoPeopleDomain/bptBaseinfoPeopleDomain");
	
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
	"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	
	IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
	BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory
	.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
	/**
	 * 查询公示书信息
	 * @return
	 */
	@Trans
	public DataSet queryOpenLetter(){
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
			DataSet od = openService.queryOpenLetter(pset);
			List<String> list = new ArrayList<String>();
			if(od.getCount()>0){
				orecord = od.getRecord(0);
				orecord.set("name", precord.get("name"));
				orecord.set("sex", precord.get("sex"));
				orecord.set("birthday", precord.get("birthday"));
				orecord.set("address", precord.get("address"));
				orecord.set("workUnitName", precord.get("workUnitName"));
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
				orecord.set("domicile", domicile);
				orecord.set("organId", organId);
				ds.add(orecord);
			}else{
				Calendar ca = Calendar.getInstance();
				ca.add(Calendar.DAY_OF_MONTH, 7);
				Date d=ca.getTime();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String date= format.format(new Date());
				String date2= format.format(d);
				orecord = new Record();
				orecord.set("name", precord.get("name"));
				orecord.set("sex", precord.get("sex"));
				orecord.set("birthday", precord.get("birthday"));
				orecord.set("address", precord.get("address"));
				orecord.set("workUnitName", precord.get("workUnitName"));
				orecord.set("openstartDate", date);
				orecord.set("openendDate", date2);
				orecord.set("openDate", date);
				orecord.set("openDays", "7");
				//list.add(organId.substring(0, 4)+"00000000");
				/*list.add(organId.substring(0, 6)+"000000");
				String domicile= findOrgan(list)+"民政局";*/
				String domicile="";
				//list.add(organId.substring(0, 6)+"000000");
				if((organId.substring(0, 4)+"00000000").equals(organId.substring(0, 6)+"000000")){
					list.add(organId.substring(0, 4)+"00000000");
					domicile= findOrgan(list)+"民政厅";
				}else{
					list.add(organId.substring(0, 4)+"00000000");
					list.add(organId.substring(0, 6)+"000000");
					domicile= findOrgan(list)+"民政局";
				}
				orecord.set("domicile", domicile);
				orecord.set("organId", organId);
				orecord.set("aplyId", applyId);
				
				BptOpenLetter open = new BptOpenLetter();
				open.setApplyId(applyId);
				open.setPeopleId(peopleId);
				open.setOpenDate(date);
				open.setOpenstartDate(date);
				open.setOpenendDate(date2);
				open.setOrganId(organId);
				openService.saveOpen(open);
				ds.add(orecord);
			}
		}
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
	/**
	 * 查询老烈士子女公示书信息
	 * @return
	 */
	@Trans
	public DataSet queryMartyOpenLetter(){
		ParameterSet pset= this.getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		DataSet ds = queryOpenLetter();
		pset.clear();
		pset.setParameter("people_id", peopleId);
		DataSet mds = martyrOffspringDomain.query(pset);
		if(mds.getCount()>0){
			Record r = mds.getRecord(0);
			if(ds.getCount()>0){
				Record rd = ds.getRecord(0);
				rd.set("statusType", r.get("statusType"));
				rd.set("lezswName", r.get("lezswName"));
				rd.set("sacrificeDate", r.get("sacrificeDate"));
				rd.set("lezswApproveDate", r.get("lezswApproveDate"));
			}
		}
		return ds ;
	}
	/**
	 * 查询60岁退役士兵公示书信息
	 * @return
	 */
	@Trans
	public DataSet querySoldierOpenLetter(){
		ParameterSet pset= this.getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		DataSet ds = queryOpenLetter();
		pset.clear();
		pset.setParameter("people_id", peopleId);
		DataSet mds = dao.query(pset);
		if(mds.getCount()>0){
			Record r = mds.getRecord(0);
			if(ds.getCount()>0){
				Record rd = ds.getRecord(0);
				rd.set("soldierYears", r.get("soldierYears"));
				rd.set("conscriptDate", r.get("conscriptDate"));
				rd.set("decruitmentDate", r.get("decruitmentDate"));
			}
		}
		return ds ;
	}
}
