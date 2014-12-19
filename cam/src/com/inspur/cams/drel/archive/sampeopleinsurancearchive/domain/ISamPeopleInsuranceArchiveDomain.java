package com.inspur.cams.drel.archive.sampeopleinsurancearchive.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;



/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface ISamPeopleInsuranceArchiveDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(SamPeopleInsuranceArchive samPeopleInsuranceArchive);

	@Trans
	public void update(SamPeopleInsuranceArchive samPeopleInsuranceArchive);

	@Trans
	public void delete(String key);
	
	@Trans
	public void save(List<SamPeopleInsuranceArchive> list);
}
