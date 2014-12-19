package com.inspur.cams.drel.archive.sampeopleincomearchive.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;


/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface ISamPeopleIncomeArchiveDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(SamPeopleIncomeArchive samPeopleIncomeArchive);

	@Trans
	public void update(SamPeopleIncomeArchive samPeopleIncomeArchive);

	@Trans
	public void delete(String key);
	
	@Trans
	public void save(List<SamPeopleIncomeArchive> list);
}
