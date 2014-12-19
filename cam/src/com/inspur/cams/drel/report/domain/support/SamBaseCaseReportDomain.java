package com.inspur.cams.drel.report.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.report.dao.ISamBaseCaseReportDao;
import com.inspur.cams.drel.report.domain.ISamBaseCaseReportDomain;

/**
 * @title:基本情况统计Domain
 * @description: 
 * @author: yanliangliang
 * @since:2012年8月27日
 * @version:1.0
*/
 public class SamBaseCaseReportDomain implements ISamBaseCaseReportDomain {
		@Reference
		private ISamBaseCaseReportDao samBaseCaseReportDao;
		/**
		 * 根据月份查询基本情况统计
		 * @return
		 */
		public DataSet queryBaseCaseByMonth(ParameterSet pset) {
			//String path=this.getClass().getClassLoader().getResource("/").toString();
			//System.out.println(path);
			return samBaseCaseReportDao.queryBaseCaseByMonth(pset);
		}
		/**
		 * 根据月份查询基本情况变化统计
		 * @return
		 */
		public DataSet queryBaseCaseChangeByMonth(ParameterSet pset) {
			return samBaseCaseReportDao.queryBaseCaseChangeByMonth(pset);
		}
		/**
		 * 根据月份查询未注销去世的低保对象
		 * @return
		 */
		public DataSet queryDeadByMonth(ParameterSet pset) {
			return samBaseCaseReportDao.queryDeadByMonth(pset);
		}
		/**
		 * 查询未注销去世的低保对象情况
		 * @return
		 */
		public DataSet queryDeadDrelObject(ParameterSet pset) {
			return samBaseCaseReportDao.queryDeadDrelObject(pset);
		}
		/**
		 * 查询未注销去世的低保对象情况(地区)
		 * @return
		 */
		public DataSet queryDeadDrelObjectByOrgan(ParameterSet pset){
			return samBaseCaseReportDao.queryDeadDrelObjectByOrgan(pset);
		}
}