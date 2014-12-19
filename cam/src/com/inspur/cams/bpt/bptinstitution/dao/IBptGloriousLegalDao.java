package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal;


/**
 * @title:IBptGloriousLegalDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public interface IBptGloriousLegalDao extends BaseCURD<BptGloriousLegal>{
	public void save(List<BptGloriousLegal> list);
	
	public void batchDeleteByBptGloriousInstitute(String[] gloriousId);
	public void batchDeleteByGloriousIds(String[] gIds);
}

