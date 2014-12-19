package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptinstitution.data.BptGloriousDetail;


/**
 * @title:IBptGloriousInstituteDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public interface IBptGloriousDetailDao extends BaseCURD<BptGloriousDetail>{
	public void save(List<BptGloriousDetail> list);
	public void batchDeleteByBptGloriousInstitute(String[] gloriousId);
	public void batchDeleteDetail(String[] gloriousId);
	public DataSet queryGlorious(ParameterSet pset) ;	
}

