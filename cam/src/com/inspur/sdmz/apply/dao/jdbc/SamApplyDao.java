package com.inspur.sdmz.apply.dao.jdbc;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;

import com.inspur.sdmz.apply.dao.ISamApplyDao;
import com.inspur.sdmz.apply.data.SamApply;
import com.inspur.sdmz.apply.util.GetOrganUtil;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.comm.util.DateUtil;
/**
 * 业务管理对应的dao实现
 * @author Administrator
 * @date 2011-4-26
 */
public class SamApplyDao extends EntityDao<SamApply> implements ISamApplyDao {
	
	public SamApplyDao() throws Exception {
		this.afterPropertiesSet();
	}
	@Override
	public Class getEntityClass() {
		return SamApply.class;
	}
	
	/**
	 *  业务管理表中对应信息的删除Dao方法
	 */
	public void delete(String[] delIds) {
		String[] sql = new String[delIds.length];
		for (int i = 0; i < delIds.length; i++) {
			sql[i] = "delete from SAM_APPLY where APPLY_ID='" + delIds[i] + "'";
		}
		batchUpdate(sql);
	}
	
	
	/**
	 * 插入更新页面对应的初始化Dao方法
	 */
	public DataSet initInsertJsp(SamApply samapply){
		
		//查询系统时间的Java代码
        String today=DateUtil.getDay();
		samapply.setApplyDate(today);
        
        //查找BSP组织结构
        BspInfo bspInfo=GetBspInfo.getBspInfo();
        IOrganProvider op = OrganFactory.getIOrganProvider();
        OrganView org = op.getOrganByOrganId(bspInfo.getCorporationOrganId());
        String orgName=org.getOrganName();
        String userName=bspInfo.getUserName();
        samapply.setCurrentOrgName(orgName);
        samapply.setAcceptPeople(userName);
        
        Record re=new Record(samapply);
        DataSet ds=new DataSet(re);
        //返回创建好的ds
        return ds ;
	}
	
	/**
	 * 查询上级单位的Dao方法
	 */
	public DataSet querySjdw(){
		OrganView org= BspUtil.getParentOrgan();
		return GetOrganUtil.getParentOrgan(org);
		 
	}
	
	/**
	 * 查询平级单位的Dao方法
	 */
	public DataSet queryPjdw(){
		OrganView[] org= BspUtil.getSameOrgan();
		return GetOrganUtil.getSameOrgan(org);
	}
	
	/**
	 * 查询下级单位的Dao方法
	 */
	public DataSet queryXjdw(){
		OrganView[] org= BspUtil.getUnderOrgan();
		return GetOrganUtil.getUnderOrgan(org);
	}
	/**
	 *  提交审核Dao方法
	 */
	public void tjsh(String[] delIds) {
		String[] sql = new String[delIds.length];
		for (int i = 0; i < delIds.length; i++) {
			sql[i] = "update SAM_APPLY set HANDLE_SIGN='1' where APPLY_ID='" + delIds[i] + "'";
		}
		batchUpdate(sql);
	}
	/**
	 *  回访Dao方法
	 */
	public void ywhf(SamApply samapply,String[] applyId) {
		String[] sql = new String[applyId.length];
		String hfr=samapply.getAcceptPeople();
		String hfsj=samapply.getApplyDate();
		String myd=samapply.getSatisDegree();
		String hfjg=samapply.getVisitResult();
		for (int i = 0; i < applyId.length; i++) {
			sql[i] = "update SAM_APPLY set RETURN_VISIT='1',VISIT_PEOPLE='"+hfr+"',VISIT_TIME='"+hfsj+"',SATIS_DEGREE='"+myd+"',VISIT_RESULT='"+hfjg+"' where APPLY_ID='" + applyId[i] + "'";
		}
		batchUpdate(sql);
	}
}
