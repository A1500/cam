package com.inspur.cams.drel.funds.release.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.funds.release.data.SamReleaseStat;

/**
 * @title:ISamReleaseStatDao
 * @description:
 * @author:
 * @since:2012-06-11
 * @version:1.0
*/
 public interface ISamReleaseStatDao extends BaseCURD<SamReleaseStat>{
	public void save(List<SamReleaseStat> list);

	public DataSet queryStatistics(ParameterSet pset);
}

