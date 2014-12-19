package com.inspur.sdmz.apply.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.apply.data.SamApply;
import com.inspur.sdmz.apply.domain.ISamApplyDomain;

/**
 * 各种综合Cmd
 * @author Administrator
 * @date 2011-4-23
 */
public class SamApplyCmd extends BaseQueryCommand {
	
	ISamApplyDomain samapplyDomain = ScaComponentFactory.getService(ISamApplyDomain.class, "SamApplyDomain/SamApplyDomain");
	
	public static final String SDMZ_RL = "00";
	
	public DataSet execute() {
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		String organId = bspInfo.getCorporationOrganId();
		IOrganProvider op = OrganFactory.getIOrganProvider();
		StruView[] struArr = op.getListByOrganId(organId, SDMZ_RL);
		List<OrganView> list  = new ArrayList<OrganView>();
		list.add(new OrganView());
		if (struArr.length > 0) {
			String parentOrganId = struArr[0].getOrganId();
			OrganView organ = op.getOrganByOrganId(parentOrganId);
			list.add(organ);
		} else {
			throw new RuntimeException("未找到对应的组织机构信息！");
		}
		DataSet ds = new DataSet();
		ds.fromListBean(list);
		return ds;
	}
	
	/**
	 * 删除操作对应delete方法
	 */
	public void delete(){
		String[] delIds=(String[]) getParameter("delIds");
		samapplyDomain.delete(delIds);
		
	}
	
	/**
	 * 插入、修改JSP页面上，初始化页面的方法
	 * @return ds
	 */
	public DataSet initInsertJsp(){
		SamApply samapply=new SamApply();
		DataSet ds=samapplyDomain.initInsertJsp(samapply);
		return ds;
	}
	
	/**
	 * 查询上级单位对应的方法
	 * @return ds
	 */
	public DataSet querySjdw(){
		DataSet ds = samapplyDomain.querySjdw();
		return ds;
	}
	
	/**
	 * 查询平级单位对应的方法
	 * @return ds
	 */
	public DataSet queryPjdw(){
		DataSet ds = samapplyDomain.queryPjdw();
		return ds;
	}
	
	/**
	 * 查询下级单位对应的方法
	 * @return ds
	 */
	public DataSet queryXjdw(){
		DataSet ds = samapplyDomain.queryXjdw();
		return ds;
	}
	
	/**
	 * 提交审核对应的方法
	 * @return ds
	 */
	public void tjsh(){
		String[] delIds=(String[]) getParameter("delIds");
		samapplyDomain.tjsh(delIds);
		
	}
}
