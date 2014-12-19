package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptinstitution.data.BptGloriousInstitute;


/**
 * @title:IBptGloriousInstituteDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public interface IBptGloriousInstituteDao extends BaseCURD<BptGloriousInstitute>{
	public void save(List<BptGloriousInstitute> list);
	public void batchDeleteGlorious(String[] fkId);
	public DataSet getMaxYear(ParameterSet pset);
}

