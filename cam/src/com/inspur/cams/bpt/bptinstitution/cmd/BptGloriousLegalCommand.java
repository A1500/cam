package com.inspur.cams.bpt.bptinstitution.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;
import com.inspur.cams.bpt.bptinstitution.domain.IBptGloriousInstituteDomain;



/**
 * @title:BptGloriousLegalCommand
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
public class BptGloriousLegalCommand extends BaseQueryCommand {

	DicBptCareerDao careerdao = (DicBptCareerDao) DaoFactory
	.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao");
	public DataSet execute() {
		IBptGloriousInstituteDomain bptgloriousinstituteDomain = ScaComponentFactory.getService(IBptGloriousInstituteDomain.class,
		"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		ParameterSet pset = getParameterSet();
		DataSet ds = bptgloriousinstituteDomain.queryBptGloriousLegal(pset);
		ParameterSet pt = new ParameterSet();
		for(int j=0;j<ds.getCount();j++){
			String majorJob = (String)ds.getRecord(j).get("majorJob");
			pt.setParameter("CODE", majorJob);
			DataSet cityds =careerdao.query(pt);
			if(cityds.getCount()>0){
				String name =(String)cityds.getRecord(0).get("name");
				ds.getRecord(j).set("majorJobName", name);
			}
		}
		return ds;
	}
	@Trans
	public void save() {
		IBptGloriousInstituteDomain bptgloriousinstituteDomain = ScaComponentFactory.getService(IBptGloriousInstituteDomain.class,
				"BptGloriousInstituteDomain/BptGloriousInstituteDomain");
		Record[] bptgloriouslegalRecords = (Record[]) getParameter("bptgloriouslegalRecords");
		List<BptGloriousLegal> list = new ArrayList<BptGloriousLegal>();
		for (int i = 0; i < bptgloriouslegalRecords.length; i++) {
			BptGloriousLegal bptgloriouslegal = (BptGloriousLegal)bptgloriouslegalRecords[i].toBean(BptGloriousLegal.class);
			list.add(bptgloriouslegal);
		}
		bptgloriousinstituteDomain.saveBptGloriousLegal(list);
	}
	@Trans
	public void delete() {
		EntityDao<BptGloriousLegal> dao = (EntityDao<BptGloriousLegal>) DaoFactory
		.getDao("com.inspur.cams.bpt.bptinstitution.dao.jdbc.BptGloriousLegalDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}