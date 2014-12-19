package com.inspur.cams.comm.diccity.cmd;


import javax.servlet.http.HttpServletRequest;

import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.dao.jdbc.DicPubCantDao;
import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.CamsProperties;


/**
 * 行政区划查询cmd
 * @author wangbaocai
 * @date 2011-6-23
 */
public class DicCityQueryCommand extends BaseQueryCommand {
	
	DicCityDao dao = (DicCityDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	DicPubCantDao dicProvice = (DicPubCantDao) DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicPubCantDao");
	/**
	 * 查询所有外省行政区划
	 * @return
	 */
	public DataSet getProvice() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "CANT_CODE");
		pset.setParameter("dir", "asc");
		DataSet ds = dicProvice.query(pset);
		ds.getMetaData().setIdProperty("CANT_CODE");
		return ds;
	}
	/**
	 * 查询所有行政区划
	 * @return
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "id");
		pset.setParameter("dir", "asc");
		DataSet ds = dao.query(pset);
		ds.getMetaData().setIdProperty("ID");
		return ds;
	}

	/**
	 * 带有权限的行政区划下级查询
	 * @return
	 */
	public DataSet getCityPermitTree() {
		ParameterSet ps = getParameterSet();
		ps.setParameter("sort", "id");
		ps.setParameter("dir", "asc");
		String parentId = (String) ps.getParameter("id");
		StruView struView = BspUtil.getCorpStru();
		if ("rootId".equals(parentId) && !BspUtil.PROVINCE.equals(struView.getOrganType())) {
			parentId = struView.getOrganCode();
			if (parentId == null || "".equals(parentId)) {
				throw new RuntimeException("没有找到当前根节点");
			}
		}
		
		return dao.getDirectUnderling(parentId);
	}
	/**
	 * 带有权限的行政区划下级查询
	 * @return
	 */
	public DataSet getCityTree() {
		ParameterSet ps = getParameterSet();
		ps.setParameter("sort", "id");
		ps.setParameter("dir", "asc");
		String parentId = (String) ps.getParameter("id");
		if ("rootId".equals(parentId)) {
			if (parentId == null || "".equals(parentId)) {
				throw new RuntimeException("没有找到当前根节点");
			}
		}
		return dao.getDirectUnder(parentId);
	}
	
	public DataSet queryCity(){
		ParameterSet pset = getParameterSet();
		return dao.queryCity(pset);
	}

	/**
	 * 带有权限的行政区划下级查询，不包含本级，按照行政区划排序
	 * @return
	 */
	public DataSet getPermitWithoutSelf() {
		ParameterSet ps = getParameterSet();
		ps.setParameter("sort", "id");
		ps.setParameter("dir", "asc");
		String parentId = (String) ps.getParameter("id");
//		StruView struView = BspUtil.getCorpStru();
//		if ("rootId".equals(parentId) && !BspUtil.PROVINCE.equals(struView.getOrganType())) {
//			parentId = struView.getOrganCode();
//			if (parentId == null || "".equals(parentId)) {
//				throw new RuntimeException("没有找到当前根节点");
//			}
//		}
		return dao.getDirectUnderlingWithoutSelf(parentId);
	}
	
	/**
	 * 查询行政区划（省市县）
	 * @return
	 */
	public DataSet queryCityCounty() {
		DataSet ds = new DataSet();
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "id");
		pset.setParameter("dir", "asc");
		String params = (String)pset.getParameter("UPS@=");
		if(params.endsWith("00000000")) {
			ds = dao.query(pset);
			ds.getMetaData().setIdProperty("ID");
		}
		return ds;
	}
	
	/**
	 * 行政区划自动补全
	 * @return
	 */
	public DataSet autoComplete() {
		String pageCount = CamsProperties.getString("autoComplete_page");
		ParameterSet pset = getParameterSet();
		String organCode = BspUtil.getOrganCode();
		pset.setParameter("organCode", organCode);
		pset.setParameter("pageCount", pageCount);
		return dao.queryAutoComplete(pset);
	}
	
} 
