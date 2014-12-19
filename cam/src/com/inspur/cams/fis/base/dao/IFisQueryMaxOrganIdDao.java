package com.inspur.cams.fis.base.dao;

/**
 * @Path com.inspur.cams.fis.base.dao
 * @Description: TODO 查询数据库中organId后两位最大值
 * @author lx
 * @date 2013-07-25
 */
public interface IFisQueryMaxOrganIdDao {
	public String queryMaxOrganId(String organId);
}
