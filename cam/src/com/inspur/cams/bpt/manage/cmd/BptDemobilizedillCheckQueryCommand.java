package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao;
import com.inspur.cams.bpt.base.data.BptDemobilizedillnessCheck;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.support.BptPeopleTestedDomain;
import com.inspur.cams.bpt.capital.dao.jdbc.BptCapitalDetailDao;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:BptPhysicalExaminationQueryCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public class BptDemobilizedillCheckQueryCommand extends BaseQueryCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	private BptDemobilizedillCheckDao checkDao = (BptDemobilizedillCheckDao) DaoFactory
		.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao");
	DicCityDao dicdao = (DicCityDao) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	public DataSet queryDemobilizedillCheck(){
		ParameterSet pset =this.getParameterSet();
		String applyId=(String)pset.get("applyId");
		String peopleId = (String)pset.get("peopleId");
		pset.clear();
		pset.setParameter("people_Id", peopleId);
		DataSet pds =service.queryPeople(pset);
		pset.setParameter("apply_Id", applyId);
		DataSet ds =  checkDao.query(pset);
		if(ds.getCount()>0&&pds.getCount()>0){
			Record r=ds.getRecord(0);
			Record pr= pds.getRecord(0);
			r.set("name", pr.get("name"));
			r.set("sex", pr.get("sex"));
			r.set("birthday", pr.get("birthday"));
			r.set("address", pr.get("address"));
			r.set("idCard", pr.get("idCard"));
			if(r.get("toOrganId")!=null&&r.get("toOrganId")!=""){
				pset.clear();
				pset.setParameter("id", (String)r.get("toOrganId"));
				DataSet dds =dicdao.query(pset);
				if(dds.getCount() > 0) {
					String organName = ((DicCity)dds.getRecord(0).toBean(DicCity.class)).getFullName();
					r.set("toOrgan", organName);
				}
			}
		}
		return ds;
	}
	
}
