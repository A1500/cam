package com.inspur.cams.bpt.bptrecuperate.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail;

/**
 * @title:IBptRecuperateDetalDao
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
*/
 public interface IBptRecuperateDetailDao extends BaseCURD<BptRecuperateDetail>{
	public void save(List<BptRecuperateDetail> list);
	public void deleteByBatchId(String[] batchIds);
	public DataSet selectByBatchId(ParameterSet pset);
}

