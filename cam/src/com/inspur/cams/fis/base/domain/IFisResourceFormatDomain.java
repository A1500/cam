package com.inspur.cams.fis.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceFormat;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisResourceFormatDomain
 * @Description: TODO 殡葬业务资源规格表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceFormatDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(FisResourceFormat fisResourceFormat);

	@Trans
	public void batchInsert(List<FisResourceFormat> list);

	@Trans
	public void update(FisResourceFormat fisResourceFormat);

	@Trans
	public void batchUpdate(List<FisResourceFormat> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisResourceFormat> list);
}