package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisResourceLevel;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisResourceLevelDao
 * @Description: TODO 殡葬业务资源级别定义表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceLevelDao extends BaseCURD<FisResourceLevel> {
	public void save(List<FisResourceLevel> list);

	public DataSet queryForExport(ParameterSet set);
}
