package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptTemporaryHelp;

/**
 * @title:IBptTemporaryHelpDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public interface IBptTemporaryHelpDao extends BaseCURD<BptTemporaryHelp>{
	public void save(List<BptTemporaryHelp> list);
	public DataSet queryTemporary(ParameterSet params);
	public DataSet queryTemporaryHelp(ParameterSet params);
	public DataSet queryUpdateTemporaryHelp(ParameterSet pset);
	//public void batchInsert(List list);
}

