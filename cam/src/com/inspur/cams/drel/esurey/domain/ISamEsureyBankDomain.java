package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureyBankDomain
 * @description:银行domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyBank;

public interface ISamEsureyBankDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyBank dataBean);

	public void insert(SamEsureyBank dataBean);

	public void save(List<SamEsureyBank> list);
	public void delete(String peopleId);
	/*
	 * 人行信息
	 */
	public void getEsureyBank(SamEsureyBank[] Beans,String peopleId);
	
	public DataSet queryExtBank(ParameterSet pset);
}
