package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:ISamEsureySocialDomain
 * @description:经济核对_家庭经济状况审核汇总domain接口
 * @author:luguosui
 * @since:2011-07-09
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyFamilySum;

public interface ISamEsureyFamilySumDomain{
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyFamilySum dataBean);

	public void insert(SamEsureyFamilySum dataBean);

	public void save(List<SamEsureyFamilySum> list);
}