package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisResourceRule;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisResourceRuleDao
 * @Description: TODO 殡葬业务资源级别规则定义表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceRuleDao extends BaseCURD<FisResourceRule> {
	public void save(List<FisResourceRule> list);

	public DataSet queryRuleList(ParameterSet pset);

	public void deleteByParentLevel(String parentLevel);
}
