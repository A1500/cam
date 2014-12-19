package com.inspur.cams.fis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.fis.base.dao.IFisResourceRuleDao;
import com.inspur.cams.fis.base.data.FisResourceRule;
import com.inspur.cams.fis.base.domain.IFisResourceRuleDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisResourceRuleDomain
 * @Description: TODO 殡葬业务资源级别规则定义表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceRuleDomain implements IFisResourceRuleDomain {

	@Reference
	private IFisResourceRuleDao fisResourceRuleDao;

	public DataSet query(ParameterSet pset) {
		return fisResourceRuleDao.query(pset);
	}

	public void insert(FisResourceRule fisResourceRule) {
	}

	public void batchInsert(List<FisResourceRule> list) {
	}

	public void update(FisResourceRule bean) {
	}

	public void batchUpdate(List<FisResourceRule> list) {
	}

	public void delete(String[] delIds) {
	}

	public void save(List<FisResourceRule> list) {
	}

	public DataSet queryRuleList(ParameterSet pset) {
		return fisResourceRuleDao.queryRuleList(pset);
	}

	public void deleteByParentLevel(String parentLevel) {
		fisResourceRuleDao.deleteByParentLevel(parentLevel);
	}

}