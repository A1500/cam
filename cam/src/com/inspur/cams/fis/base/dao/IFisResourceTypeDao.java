package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisResourceType;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisResourceTypeDao
 * @Description: TODO 殡葬业务资源分类表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceTypeDao extends BaseCURD<FisResourceType> {
	public void save(List<FisResourceType> list);

	public DataSet queryForExport(ParameterSet set);
}
