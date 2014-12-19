package com.inspur.cams.drel.funds.release.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.funds.release.data.SamReleaseStat;

/**
 * @title:ISamReleaseStatDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public interface ISamReleaseStatDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(SamReleaseStat samReleaseStat);

	@Trans
	public void update(SamReleaseStat samReleaseStat);

	@Trans
	public void delete(String key);
	
	@Trans
	public void save(List<SamReleaseStat> list);

	public DataSet queryStatistics(ParameterSet pset);

}