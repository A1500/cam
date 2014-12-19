package com.inspur.cams.fis.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceType;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisResourceTypeDomain
 * @Description: TODO 殡葬业务资源分类表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceTypeDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(FisResourceType fisResourceType);

	@Trans
	public void batchInsert(List<FisResourceType> list);

	@Trans
	public void update(FisResourceType fisResourceType);

	@Trans
	public void batchUpdate(List<FisResourceType> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisResourceType> list);

	public DataSet queryForExport(ParameterSet set);
}