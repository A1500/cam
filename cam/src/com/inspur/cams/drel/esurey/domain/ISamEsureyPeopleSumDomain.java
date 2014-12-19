package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum;

public interface ISamEsureyPeopleSumDomain {
	
	public DataSet query(ParameterSet ps);
	
	public void save(List<SamEsureyPeopleSum> list);
	
	public void batchDelete(String[] ids);
	
	public void insert(SamEsureyPeopleSum dataBean);
	
	public void update(SamEsureyPeopleSum dataBean);

}
