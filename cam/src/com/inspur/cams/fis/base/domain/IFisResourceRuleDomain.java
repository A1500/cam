package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceRule;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisResourceRuleDomain
 * @Description: TODO 殡葬业务资源级别规则定义表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisResourceRuleDomain {

	public DataSet query(ParameterSet pset);

	public DataSet queryRuleList(ParameterSet pset);

	@Trans
	public void insert(FisResourceRule fisResourceRule);

	@Trans
	public void batchInsert(List<FisResourceRule> list);

	@Trans
	public void update(FisResourceRule fisResourceRule);

	@Trans
	public void batchUpdate(List<FisResourceRule> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void deleteByParentLevel(String parentLevel);

	@Trans
	public void save(List<FisResourceRule> list);
}