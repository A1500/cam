package com.inspur.cams.fis.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceLevel;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisResourceLevelDomain
 * @Description: TODO 殡葬业务资源级别定义表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceLevelDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(FisResourceLevel fisResourceLevel);

	@Trans
	public void batchInsert(List<FisResourceLevel> list);

	@Trans
	public void update(FisResourceLevel fisResourceLevel);

	@Trans
	public void batchUpdate(List<FisResourceLevel> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisResourceLevel> list);

	public DataSet queryForExport(ParameterSet set);
}